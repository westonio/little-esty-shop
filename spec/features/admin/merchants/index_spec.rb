require 'rails_helper'

RSpec.describe "Admin Merchants Index Page" do
  before :each do
    @merchant_1 = Merchant.create!(name: "Schroeder-Jerde")
    @merchant_2 = Merchant.create!(name: "Klein, Rempel and Jones")
    @merchant_3 = Merchant.create!(name: "Willms and Sons")
    @merchant_4 = Merchant.create!(name: "Cummings-Thiel")
    @merchant_5 = Merchant.create!(name: "Williamson Group")
    @merchant_6 = Merchant.create!(name: "Bernhard-Johns")

    visit admin_merchants_path
  end

  it "displays the name of each merchant in the system" do
    expect(page).to have_content(@merchant_1.name)
    expect(page).to have_content(@merchant_2.name)
    expect(page).to have_content(@merchant_3.name)
    expect(page).to have_content(@merchant_4.name)
    expect(page).to have_content(@merchant_5.name)
    expect(page).to have_content(@merchant_6.name)
    expect(page).to_not have_content("Johnson-Dickinson")
  end

  it "links to the merchant show page when you click the merchant's name" do
    click_link(@merchant_1.name)
    expect(current_path).to eq(admin_merchant_path(@merchant_1))

    visit admin_merchants_path
    
    click_link(@merchant_2.name)
    expect(current_path).to eq(admin_merchant_path(@merchant_2))
  end

  describe "disable/enable merchants button" do
    it "disables or enables the merchant when clicked" do
      expect(@merchant_1.status).to eq("disabled")
      click_button "Enable #{@merchant_1.name}"

      @merchant_1.reload
      expect(@merchant_1.status).to eq("enabled")


      visit admin_merchants_path
      expect(@merchant_2.status).to eq("disabled")
      click_button "Enable #{@merchant_2.name}"

      @merchant_2.reload
      expect(@merchant_2.status).to eq("enabled")
    end

    it "displays the updated merchant status once clicked" do
      click_button "Enable #{@merchant_1.name}"
      @merchant_1.reload
      
      expect(page).to have_button("Disable #{@merchant_1.name}")
      
      click_button "Disable #{@merchant_1.name}"
      @merchant_1.reload
      
      expect(page).to have_button("Enable #{@merchant_1.name}")
    end
  end

  it "displays the enabled and disabled merchants in two separate sections" do
    click_button "Enable #{@merchant_1.name}"
    click_button "Enable #{@merchant_2.name}"
    click_button "Enable #{@merchant_4.name}"
    click_button "Enable #{@merchant_6.name}"
    @merchant_1.reload
    @merchant_2.reload
    @merchant_4.reload
    @merchant_6.reload

    expect("Enabled Merchants").to appear_before("Disabled Merchants")

    within("#enabled-merchants") do
      expect(page).to have_content(@merchant_1.name)
      expect(page).to have_content(@merchant_2.name)
      expect(page).to have_content(@merchant_4.name)
      expect(page).to have_content(@merchant_6.name)
      expect(page).to_not have_content(@merchant_3.name)
    end

    within("#disabled-merchants") do
    expect(page).to have_content(@merchant_3.name)
    expect(page).to have_content(@merchant_5.name)
    expect(page).to_not have_content(@merchant_1.name)
    end
  end

  it "has a link to create a new merchant" do
    expect(page).to have_link("Create New Merchant")
  end

  it "links to a form to add info and create new merchant" do
    click_link("Create New Merchant")

    expect(current_path).to eq(new_admin_merchant_path)
    expect(page).to have_field("name")
    expect(page).to have_button("Submit")
  end

  describe "new merchant form submission" do
    before :each do
      click_link("Create New Merchant")

      fill_in "Name", with: "Omnia Vintage"
      click_button("Submit")
    end

    it "creates a new merchant instance upon form submission" do
      expect(Merchant.last.name).to eq("Omnia Vintage")
    end

    it "redirects to index, which displays the new merchant with default status disabled" do
      expect(current_path).to eq(admin_merchants_path)
      expect(Merchant.last.status).to eq("disabled")

      within("#disabled-merchants") do
        expect(page).to have_content("Omnia Vintage")
      end
    end
  end

  xit "displays the top 5 merchants by total revenue generated" do

  end

  xit "links each top merchant name to its admin merchant show page" do

  end

#   As an admin,
# When I visit the admin merchants index (/admin/merchants)
# Then I see the names of the top 5 merchants by total revenue generated
# And I see that each merchant name links to the admin merchant show page for that merchant
# And I see the total revenue generated next to each merchant name

# Notes on Revenue Calculation:

# Only invoices with at least one successful transaction should count towards revenue
# Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
# Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)
end