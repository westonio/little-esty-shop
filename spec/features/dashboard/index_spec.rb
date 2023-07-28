require "rails_helper"

RSpec.describe "Merchant Dashboard" do
  before(:each) do
    @m1 = Merchant.create!(name: "Schroeder-Jerde")
    @m2 = Merchant.create!(name: "Klein, Rempel and Jones")
    @m3 = Merchant.create!(name: "Willms and Sons")
    @m4 = Merchant.create!(name: "Cummings-Thiel")
    @m5 = Merchant.create!(name: "Williamson Group")
  end
  #user story 1
  it "displays the name of each merchant" do
    visit "/merchants/#{@m1.id}/dashboard"

    expect(page).to have_content(@m1.name)
    expect(page).to_not have_content(@m2.name)
  end
  #user story 2
  it "displays a link to merchant items index and merchant invoices index pages" do
    visit "/merchants/#{@m1.id}/dashboard"

    expect(page).to have_link("My Items")
    expect(page).to have_link("My Invoices")
    expect(page).to_not have_link("Admin")
  end
  #user story 3
  it "displays the names of the top 5 customers" do
    visit "/merchants/#{@m1.id}/dashboard"

    expect(page).to have_content("Favorite Customers")
  end
end