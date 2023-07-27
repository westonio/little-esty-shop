require 'rails_helper'


RSpec.describe "Admin Merchants Edit Page" do
  before :each do
    @merchant_1 = Merchant.create!(name: "Schroeder-Jerde")
    @merchant_2 = Merchant.create!(name: "Klein, Rempel and Jones")
    @merchant_3 = Merchant.create!(name: "Willms and Sons")
  end

  describe "edit form" do
    it "has an autopopulated name field with existing info" do
      visit edit_admin_merchant_path(@merchant_1)
      expect(page).to have_field("Name", with: @merchant_1.name)
    end

    it "will update the name upon submission which is reflected in a flash message" do
      visit edit_admin_merchant_path(@merchant_1)
      fill_in "Name", with: "Cocokind"
      click_button "Submit"
      
      @merchant_1.reload
      
      expect(current_path).to eq(admin_merchant_path(@merchant_1))
      
      expect(page).to have_content("Cocokind")
      expect(@merchant_1.name).to eq("Cocokind")
      expect(page).to have_content("Cocokind has been successfully updated")
    end

    it "will function the same if no changes were made to the autopopulated field" do
      visit edit_admin_merchant_path(@merchant_2)
      fill_in "Name", with: "Klein, Rempel and Jones"
      click_button "Submit"
      
      @merchant_2.reload
      
      expect(current_path).to eq(admin_merchant_path(@merchant_2))
      
      expect(page).to have_content("Klein, Rempel and Jones")
      expect(@merchant_2.name).to eq("Klein, Rempel and Jones")
      expect(page).to have_content("Klein, Rempel and Jones has been successfully updated")
    end

    it "will not allow submission with an empty text field" do
      visit edit_admin_merchant_path(@merchant_3)
      fill_in "Name", with: ""
      click_button "Submit"

      @merchant_3.reload

      expect(page).to have_field("Name")
      expect(page).to have_content("Please enter a merchant name to continue.")
    end
  end
end