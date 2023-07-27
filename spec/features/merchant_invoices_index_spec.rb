require 'rails_helper'

RSpec.describe 'Merchant Invoices Index' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @customer1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')

    @item1 = @merchant1.items.create!(name: 'Shampoo', description: 'This washes your hair', unit_price: 10, status: 0)
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
end
