require "rails_helper"

RSpec.describe "Merchant Dashboard" do
  before(:each) do
    @m1 = Merchant.create!(name: "Schroeder-Jerde")
    @m2 = Merchant.create!(name: "Klein, Rempel and Jones")
    @m3 = Merchant.create!(name: "Willms and Sons")
    @m4 = Merchant.create!(name: "Cummings-Thiel")
    @m5 = Merchant.create!(name: "Williamson Group")
  end
  it "displays the name of each merchant" do
    visit "/merchants/#{@m1.id}/dashboard"

    expect(page).to have_content(@m1.name)
  end
end