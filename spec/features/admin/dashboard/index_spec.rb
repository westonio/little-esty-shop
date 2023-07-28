require 'rails_helper'

RSpec.describe 'Admin Dashboard (index)', type: :feature do
  describe 'When I visit the admin dashboard (/admin)' do
    before :each do
      visit admin_path
    end
    
    it "Has a header indicating that I am on the admin dashboard" do 
      expect(page).to have_content("Admin Dashboard", count: 1)
    end
  end
end