require 'rails_helper'

RSpec.describe "Admin Merchants New Page" do
  before :each do
    @merchant_1 = Merchant.create!(name: "Schroeder-Jerde")
    @merchant_2 = Merchant.create!(name: "Klein, Rempel and Jones")
    @merchant_3 = Merchant.create!(name: "Willms and Sons")
    @merchant_4 = Merchant.create!(name: "Cummings-Thiel")
    @merchant_5 = Merchant.create!(name: "Williamson Group")
    @merchant_6 = Merchant.create!(name: "Bernhard-Johns")

    visit new_admin_merchant_path
  end

  it "has a field to fill in merchant name and a submission button" do
    expect(page).to have_field("name")
    expect(page).to have_button("Submit")
  end

  describe "successful form submission" do
    before :each do
      fill_in "Name", with: "Omnia Vintage"
      click_button("Submit")
    end

    it "creates a new merchant instance" do
      expect(Merchant.last.name).to eq("Omnia Vintage")
    end

    it "redirects to index" do
      expect(current_path).to eq(admin_merchants_path)
    end
    
    it "displays the default merchant status as disabled" do
      expect(Merchant.last.status).to eq("disabled")
  
      within("#disabled-merchants") do
        expect(page).to have_content("Omnia Vintage")
      end
    end
  end

  describe "unsuccessful form submission" do
    before :each do
      fill_in "Name", with: ""
      click_button("Submit")
    end

    it "displays a flash message notifying user of merchant creation failure" do
      expect(page).to have_content("Please enter a merchant name to continue.")
    end

    it "renders a new creation form" do
      expect(page).to have_field("Name")
      expect(page).to have_button("Submit")
    end
  end
end