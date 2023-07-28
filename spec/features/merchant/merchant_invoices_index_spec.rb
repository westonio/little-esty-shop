require 'rails_helper'

RSpec.describe 'Merchant Invoices Index' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @customer1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')

    @item1 = @merchant1.items.create!(name: 'Shampoo', description: 'This washes your hair', unit_price: 10,
                                      status: 0)
    @invoice1 = @customer1.invoices.create!(status: 1)

    InvoiceItem.create!(item: @item1, invoice: @invoice1, quantity: 1, unit_price: 10, status: 0)
  end

  # User Story 14 Testing Begins

  # As a merchant,
  # When I visit my merchant's invoices index (/merchants/:merchant_id/invoices)
  # Then I see all of the invoices that include at least one of my merchant's items
  # And for each invoice I see its id
  # And each id links to the merchant invoice show page
  it 'displays all of the invoices that include at least one of my merchants items' do
    visit merchant_invoices_path(@merchant1)

    expect(page).to have_content(@invoice1.id)
  end

  it 'links each invoice id to the merchant invoice show page' do
    visit merchant_invoices_path(@merchant1)
    within "#invoice-#{@invoice1.id}" do
      expect(page).to have_link(@invoice1.id.to_s, href: merchant_invoice_path(@merchant1, @invoice1))
    end
  end
  # User Story 14 Testing End

  # User Story 15 Testing Begins

  # As a merchant
  # When I visit my merchant's invoice show page (/merchants/:merchant_id/invoices/:invoice_id)
  # Then I see information related to that invoice including:

  # Invoice id
  # Invoice status
  # Invoice created_at date in the format "Monday, July 18, 2019"
  # Customer first and last name

  it 'displays the invoice id and status on the merchants show page' do
    visit merchant_invoice_path(@merchant1, @invoice1)

    expect(page).to have_content(@invoice1.id)
    expect(page).to have_content(@invoice1.status)
  end

  it 'displays the invoice created_at date in the format "Monday, July 18, 2019"' do
    visit merchant_invoice_path(@merchant1, @invoice1)

    expect(page).to have_content(@invoice1.created_at.strftime('%A, %B %d, %Y'))
  end

  it 'displays the customer first and last name' do
    visit merchant_invoice_path(@merchant1, @invoice1)

    expect(page).to have_content(@customer1.first_name)
    # User Story 15 Testing End
  end

  # User Story 16 Testing Begins

  # As a merchant
  # When I visit my merchant invoice show page (/merchants/:merchant_id/invoices/:invoice_id)
  # Then I see all of my items on the invoice including:

  # Item name
  # The quantity of the item ordered
  # The price the Item sold for
  # The Invoice Item status
  # And I do not see any information related to Items for other merchants

  it 'displays item name, quantity, price, and invoice item status for this merchant only' do
    visit merchant_invoice_path(@merchant1, @invoice1)

    expect(page).to have_content(@item1.name)
    expect(page).to have_content(@item1.quantity)
    expect(page).to have_content(@item1.unit_price)
    expect(page).to have_content(@item1.status)
  end
end
