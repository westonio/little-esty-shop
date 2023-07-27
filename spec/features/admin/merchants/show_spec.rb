require 'rails_helper'

RSpec.describe "Admin Merchants Show Page" do
  before :each do
    @merchant_1 = Merchant.create!(name: "Schroeder-Jerde")
    @merchant_2 = Merchant.create!(name: "Klein, Rempel and Jones")
    @merchant_3 = Merchant.create!(name: "Willms and Sons")
  end

  it "displays the name of the merchant" do
    visit "/admin/merchants/#{@merchant_1.id}"
    expect(page).to have_content(@merchant_1.name)
    expect(page).to_not have_content(@merchant_2.name)
    
    visit "/admin/merchants/#{@merchant_2.id}"
    expect(page).to have_content(@merchant_2.name)
    expect(page).to_not have_content(@merchant_3.name)
  end

end