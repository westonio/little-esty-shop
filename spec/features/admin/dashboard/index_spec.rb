require 'rails_helper'

RSpec.describe 'Admin Dashboard (index)', type: :feature do
  describe 'When I visit the admin dashboard (/admin)' do
    before :each do
      visit admin_path
    end
    
    it "Has a header indicating that I am on the admin dashboard" do 
      expect(page).to have_content("Admin Dashboard", count: 1)
    end

    it "I see a link to the admin merchants index (/admin/merchants)" do
      expect(page).to have_link "Merchants"

      click_link "Merchants"

      expect(current_path).to eq(admin_merchants_path)
    end

    it "I see a link to the admin invoices index (/admin/invoices)" do
      expect(page).to have_link "Invoices"

      click_link "Invoices"
      
      expect(current_path).to eq(admin_invoices_path)
    end

    it "I see a link to the admin dashboard index(/admin)" do
      visit admin_invoices_path
      
      expect(page).to have_link "Dashboard"

      click_link "Dashboard"
      
      expect(current_path).to eq(admin_path)
    end
  end
end