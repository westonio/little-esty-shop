require 'rails_helper'

RSpec.describe 'Merchant Invoices Index' do
  include ActionView::Helpers::NumberHelper

  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Jewelry')

    @customer1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')

    @item1 = @merchant1.items.create!(name: 'Shampoo', description: 'This washes your hair', unit_price: 10,
                                      status: 0)
    @item2 = @merchant2.items.create!(name: 'Conditioner', description: 'This makes your hair shiny', unit_price: 20,
                                      status: 0)

    @invoice1 = @customer1.invoices.create!(status: 1)
    @invoice2 = @customer1.invoices.create!(status: 1)

    @invoice_item1 = InvoiceItem.create!(item: @item1, invoice: @invoice1, quantity: 1, unit_price: 10, status: 0)
    @invoice_item2 = InvoiceItem.create!(item: @item2, invoice: @invoice2, quantity: 1, unit_price: 20, status: 0)
  end

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

  it 'displays item name, quantity, price, and invoice item status for this merchant' do
    visit merchant_invoice_path(@merchant1, @invoice1)

    @invoice1.invoice_items.each do |invoice_item|
      expect(page).to have_content(invoice_item.item.name)
      expect(page).to have_content(invoice_item.quantity)
      expect(page).to have_content(number_to_currency(invoice_item.unit_price / 100.0))
      expect(page).to have_content(invoice_item.status)
    end
  end

  it 'does not display any information related to items for other merchants' do
    visit merchant_invoice_path(@merchant1, @invoice1)

    @invoice1.invoice_items.each do |_invoice_item|
      expect(page).to_not have_content(@item2.name)
      expect(page).to_not have_content(@item2.description)
      expect(page).to_not have_content(number_to_currency(@item2.unit_price / 100.0))
      expect(page).to_not have_content(@item2.status)
    end
    # User Story 16 Testing End
  end

  # User Story 17 Testing Begins

  # As a merchant
  # When I visit my merchant invoice show page (/merchants/:merchant_id/invoices/:invoice_id)
  # Then I see the total revenue that will be generated from all of my items on the invoice

  it 'displays the total revenue generated from all of my items on the invoice' do
    visit merchant_invoice_path(@merchant1, @invoice1)

    expect(page).to have_content(number_to_currency(@invoice1.total_revenue / 100.0))
    # User Story 17 Testing End
  end

  # User Story 18 Testing Begins

  #   As a merchant
  # When I visit my merchant invoice show page (/merchants/:merchant_id/invoices/:invoice_id)
  # I see that each invoice item status is a select field
  # And I see that the invoice item's current status is selected
  # When I click this select field,
  # Then I can select a new status for the Item,
  # And next to the select field I see a button to "Update Item Status"
  # When I click this button
  # I am taken back to the merchant invoice show page
  # And I see that my Item's status has now been updated

  it 'each status field contains a dropdown select field with the current status selected' do
    visit merchant_invoice_path(@merchant1, @invoice1)

    @invoice1.invoice_items.each do |invoice_item|
      expect(find("select[id='invoice_item_status_#{invoice_item.id}']").value).to eq invoice_item.status
    end
  end

  it 'each status field contains a dropdown select field with all possible statuses' do
    visit merchant_invoice_path(@merchant1, @invoice1)

    @invoice1.invoice_items.each do |invoice_item|
      dropdown_id = "invoice_item_status_#{invoice_item.id}"
      InvoiceItem.statuses.keys.each do |status|
        expect(page).to have_select(dropdown_id, with_options: [status])
      end
    end
  end

  it 'allows to change status of invoice item and updates it' do
    visit merchant_invoice_path(@merchant1, @invoice1)
    invoice_item = @invoice1.invoice_items.first
    dropdown_id = "invoice_item_status_#{invoice_item.id}"
    new_status = InvoiceItem.statuses.keys.reject { |status| status == invoice_item.status }.first
    select new_status, from: dropdown_id
    click_button 'Update Item Status'
    expect(current_path).to eq(merchant_invoice_path(@merchant1, @invoice1))
    expect(page).to have_select(dropdown_id, selected: new_status)
  end
end
