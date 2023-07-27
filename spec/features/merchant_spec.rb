require 'rails_helper'

RSpec.describe Merchant do

  before do
    @merchant_1 = Merchant.create!(id: 1, name: "Dani")
    @merchant_2 = Merchant.create!(name: "Mike")
    @item_1 = Item.create!(name: "Apple", description: "This is an apple", unit_price: 1, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: "Orange", description: "This is an orange", unit_price: 1, merchant_id: @merchant_1.id)
    @item_3 = Item.create!(name: "Lemon", description: "This is a lemon", unit_price: 1, merchant_id: @merchant_1.id)
    @item_4 = Item.create!(name: "Lime", description: "This is a lime", unit_price: 1, merchant_id: @merchant_2.id)
  end

  #6. Merchant Items Index Page
  describe "As a merchant," do
    describe "When I visit my merchant items index page (merchants/:merchant_id/items)" do
      describe "I see a list of the names of all of my items" do
        it "And I do not see items for any other merchant" do


          visit "merchants/#{@merchant_1.id}/items"

          @merchant_1_items = [@item_1, @item_2, @item_3]

          @merchant_1_items.each do |item|
            expect(page).to have_content(item.name)
          end

          expect(page).not_to have_content(@item_4.name)
        end
      end
    end
  end

  #7. Merchant Items Index Page
  describe "As a merchant," do
    describe "When I click on the name of an item from the merchant items index page, (merchants/:merchant_id/items)" do
      describe "Then I am taken to that merchant's item's show page (/merchants/:merchant_id/items/:item_id)" do
        it "And I see all of the item's attributes including: Name, Description, and Current Selling Price" do

          visit "merchants/#{@merchant_1.id}/items"

          click_link @item_1.name

          expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item_1.id}")

          expect(page).to have_content(@item_1.name)
          expect(page).to have_content(@item_1.description)
          expect(page).to have_content(@item_1.unit_price)
        end
      end
    end
  end
end
