require 'rails_helper'

RSpec.describe Merchant do
  #6. Merchant Items Index Page
  describe "As a merchant," do
    describe "When I visit my merchant items index page (merchants/:merchant_id/items)" do
      describe "I see a list of the names of all of my items" do
        it "And I do not see items for any other merchant" do
          merchant_1 = Merchant.create!(id: 1, name: "Dani")
          merchant_2 = Merchant.create!(name: "Mike")
          item_1 = Item.create!(name: "Apple", description: "This is an apple", unit_price: 1, merchant_id: merchant_1.id)
          item_2 = Item.create!(name: "Orange", description: "This is an orange", unit_price: 1, merchant_id: merchant_1.id)
          item_3 = Item.create!(name: "Lemon", description: "This is a lemon", unit_price: 1, merchant_id: merchant_1.id)
          item_4 = Item.create!(name: "Lime", description: "This is a lime", unit_price: 1, merchant_id: merchant_2.id)

          visit "merchants/#{merchant_1.id}/items"

          merchant_1_items = [item_1, item_2, item_3]

          merchant_1_items.each do |item|
            expect(page).to have_content(item.name)
          end

          expect(page).not_to have_content(item_4.name)
        end
      end
    end
  end
end
