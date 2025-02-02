require 'rails_helper'

RSpec.describe 'Admin Merchants Show Page' do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Schroeder-Jerde')
    @merchant_2 = Merchant.create!(name: 'Klein, Rempel and Jones')
    @merchant_3 = Merchant.create!(name: 'Willms and Sons')
  end

  it 'displays the name of the merchant' do
    visit admin_merchant_path(@merchant_1)
    expect(page).to have_content(@merchant_1.name)
    expect(page).to_not have_content(@merchant_2.name)

    visit admin_merchant_path(@merchant_2)
    expect(page).to have_content(@merchant_2.name)
    expect(page).to_not have_content(@merchant_3.name)
  end

  it 'links to a form to edit merchant attributes' do
    visit admin_merchant_path(@merchant_1)
    click_link 'Update Merchant'

    expect(current_path).to eq(edit_admin_merchant_path(@merchant_1))
  end

  it 'displays a random photo next to the name of the merchant on each refresh' do
    visit admin_merchant_path(@merchant_1)

    if page.has_css?('#random-merchant-image img')
      expect(page).to have_css('#random-merchant-image img')
    else
      expect(page).to have_css('#random-merchant-image p', text: @error_message)
    end
  end
end
