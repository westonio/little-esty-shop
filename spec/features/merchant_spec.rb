require 'rails_helper'

RSpec.describe Merchant do
  before do
    @merchant_1 = Merchant.create!(id: 1, name: 'Dani')
    @merchant_2 = Merchant.create!(name: 'Mike')
    @customer_1 = Customer.create!(first_name: "Anna", last_name: "Wiley")
    @item_1 = Item.create!(name: 'Apple', description: 'This is an apple', unit_price: 1, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: 'Orange', description: 'This is an orange', unit_price: 1, merchant_id: @merchant_1.id)
    @item_3 = Item.create!(name: 'Lemon', description: 'This is a lemon', unit_price: 1, merchant_id: @merchant_1.id)
    @item_4 = Item.create!(name: 'Lime', description: 'This is a lime', unit_price: 1, merchant_id: @merchant_2.id)

    @invoice_1 = @customer_1.invoices.create!(status: 1)
    @invoice_2 = @customer_1.invoices.create!(status: 1)

    @invoice_item_1 = InvoiceItem.create!(item: @item_1, invoice: @invoice_1, quantity: 4, unit_price: 10, status: 0)
    @invoice_item_2 = InvoiceItem.create!(item: @item_1, invoice: @invoice_2, quantity: 1, unit_price: 20, status: 0)
  end

  # 6. Merchant Items Index Page
  describe 'As a merchant,' do
    describe 'When I visit my merchant items index page (merchants/:merchant_id/items)' do
      describe 'I see a list of the names of all of my items' do
        it 'And I do not see items for any other merchant' do
          visit merchant_items_path(@merchant_1)

          @merchant_1_items = [@item_1, @item_2, @item_3]

          @merchant_1_items.each do |item|
            expect(page).to have_content(item.name)
          end

          expect(page).not_to have_content(@item_4.name)
        end
      end
    end
  end

  # 7. Merchant Items Index Page
  describe 'As a merchant,' do
    describe 'When I click on the name of an item from the merchant items index page, (merchants/:merchant_id/items)' do
      describe "Then I am taken to that merchant's item's show page (/merchants/:merchant_id/items/:item_id)" do
        it "And I see all of the item's attributes including: Name, Description, and Current Selling Price" do
          visit merchant_items_path(@merchant_1)

          click_link @item_1.name

          expect(current_path).to eq(merchant_item_path(@merchant_1, @item_1))

          expect(page).to have_content(@item_1.name)
          expect(page).to have_content(@item_1.description)
          expect(page).to have_content(@item_1.unit_price)
        end
      end
    end
  end

  # 8. Merchant Items Index Page
  describe 'As a merchant,' do
    describe 'When I visit the merchant show page of an item (/merchants/:merchant_id/items/:item_id)' do
      describe 'I see a link to update the item information.' do
        describe 'When I click the link' do
          describe 'Then I am taken to a page to edit this item' do
            describe 'And I see a form filled in with the existing item attribute information' do
              describe 'When I update the information in the form and I click submit' do
                describe 'Then I am redirected back to the item show page where I see the updated information' do
                  it 'And I see a flash message stating that the information has been successfully updated.' do
                    visit merchant_item_path(@merchant_1, @item_1)

                    click_link "Edit #{@item_1.name}"

                    expect(current_path).to eq(edit_merchant_item_path(@merchant_1, @item_1))

                    expect(page).to have_field("Name", with: @item_1.name)
                    expect(page).to have_field("Description", with: @item_1.description)
                    expect(page).to have_field("Unit price", with: @item_1.unit_price)

                    fill_in 'Name', with: 'Tomato'
                    fill_in 'Description', with: 'This is a tomato'

                    click_button 'Submit'

                    @item_1.reload

                    expect(@item_1.name).to eq('Tomato')
                    expect(@item_1.description).to eq('This is a tomato')
                    expect(@item_1.unit_price).to eq(1)

                    expect(current_path).to eq(merchant_item_path(@merchant_1, @item_1))
                    expect(page).to have_content("#{@item_1.name} has been updated!")
                  end
                end
              end
            end
          end
        end
      end
    end
  end

  #9. Merchant Items Index Page
  describe "As a merchant" do
    describe "When I visit my items index page (/merchants/:merchant_id/items)" do
      describe "Next to each item name I see a button to disable or enable that item." do
        describe "When I click this button" do
          describe "Then I am redirected back to the items index" do
            it "And I see that the items status has changed" do

              visit merchant_items_path(@merchant_1)

              expect(page).to have_button("Enable #{@item_1.name}")
              expect(page).to have_button("Enable #{@item_2.name}")
              expect(page).to have_button("Enable #{@item_3.name}")


              click_button("Enable #{@item_1.name}")

              @item_1.reload

              expect(current_path).to eq(merchant_items_path(@merchant_1))
              expect(page).to have_button("Disable #{@item_1.name}")
              expect(page).to have_button("Enable #{@item_2.name}")
              expect(page).to have_button("Enable #{@item_3.name}")
            end
          end
        end
      end
    end
  end

#10. Merchant Items Grouped by Status

describe "As a merchant," do
  describe "When I visit my merchant items index page" do
    describe "Then I see two sections, one for Enabled Items and one for Disabled Items" do
        it "And I see that each Item is listed in the appropriate section" do

          visit merchant_items_path(@merchant_1)

          click_button("Enable #{@item_1.name}")

          expect(page).to have_content("Enabled Items")
          expect(page).to have_content("Disabled Items")

          expect(@item_1.name).to appear_before("Disabled Items", only_text: true)

          expect(@item_2.name).to_not appear_before("Disabled Items", only_text: true)
          expect(@item_3.name).to_not appear_before("Disabled Items", only_text: true)
        end
      end
    end
  end

  #11. Merchant Items Grouped by Status
  describe "As a merchant" do
    describe "When I visit my items index page" do
      describe "I see a link to create a new item." do
        describe "When I click on the link," do
          describe "I am taken to a form that allows me to add item information." do
            describe "When I fill out the form I click ‘Submit’" do
              describe "Then I am taken back to the items index page" do
                describe "And I see the item I just created displayed in the list of items." do
                  it "And I see my item was created with a default status of disabled." do


                    visit merchant_items_path(@merchant_1)

                    expect(page).to have_link("Create new item")

                    click_link("Create new item")

                    expect(current_path).to eq(new_merchant_item_path(@merchant_1))

                    fill_in "Name", with: "Peach"
                    fill_in "Description", with: "This is a peach"
                    fill_in "Unit price", with: 3

                    click_button "Submit"

                    expect(current_path).to eq(merchant_items_path(@merchant_1))
                    expect(page).to have_link("Peach")
                    expect(Item.last.status).to eq("disabled")
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  #12. Merchant Items Index: 5 most popular items
  # Notes on Revenue Calculation:

  # Only invoices with at least one successful transaction should count towards revenue
  # Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
  # Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)

  describe "As a merchant" do
    describe "When I visit my items index page" do
      describe "Then I see the names of the top 5 most popular items ranked by total revenue generated" do
        describe "And I see that each item name links to my merchant item show page for that item" do
          it "And I see the total revenue generated next to each item name" do

            visit merchant_items_path(@merchant_1)
            require 'pry'; binding.pry

            expect(page).to have_content("Top 5 items")
            expect(@item_1.name).to_not appear_before("Top 5 items", only_text: true)
            expect(@item_2.name).to_not appear_before(@item_1.name)

            expect(page).to have_link(@item_1.name)
            expect(page).to have_link(@item_2.name)



          end
        end
      end
    end
  end
end
