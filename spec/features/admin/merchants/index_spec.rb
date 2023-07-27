require 'rails_helper'

RSpec.describe "Admin Merchants Index Page" do
  before :each do
    @merchant_1 = Merchant.create!(name: "Schroeder-Jerde")
    @merchant_2 = Merchant.create!(name: "Klein, Rempel and Jones")
    @merchant_3 = Merchant.create!(name: "Willms and Sons")
    @merchant_4 = Merchant.create!(name: "Cummings-Thiel")
    @merchant_5 = Merchant.create!(name: "Williamson Group")
    @merchant_6 = Merchant.create!(name: "Bernhard-Johns")
  end

  it "displays the name of each merchant in the system" do
    visit "/admin/merchants"

    expect(page).to have_content(@merchant_1.name)
    expect(page).to have_content(@merchant_2.name)
    expect(page).to have_content(@merchant_3.name)
    expect(page).to have_content(@merchant_4.name)
    expect(page).to have_content(@merchant_5.name)
    expect(page).to have_content(@merchant_6.name)
    expect(page).to_not have_content("Johnson-Dickinson")
  end

  it "links to the merchant show page when you click the merchant's name" do
    visit "/admin/merchants"

    click_link(@merchant_1.name)
    expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")

    visit "/admin/merchants"
    
    click_link(@merchant_2.name)
    expect(current_path).to eq("/admin/merchants/#{@merchant_2.id}")
  end
end