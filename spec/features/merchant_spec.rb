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

    @invoice_1 = @customer_1.invoices.create!(status: 2)
    @invoice_2 = @customer_1.invoices.create!(status: 2)

    @invoice_item_1 = InvoiceItem.create!(item: @item_1, invoice: @invoice_1, quantity: 4, unit_price: 10, status: 2)
    @invoice_item_3 = InvoiceItem.create!(item: @item_2, invoice: @invoice_1, quantity: 5, unit_price: 40, status: 2)
    @invoice_item_2 = InvoiceItem.create!(item: @item_4, invoice: @invoice_2, quantity: 1, unit_price: 20, status: 2)
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

                    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item_1.id}/edit")

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

                    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")

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
            @joey = Customer.create!(first_name: 'Joey', last_name: 'Ondricka')
            @cecelia = Customer.create!(first_name: 'Cecelia', last_name: 'Osinski')
            @mariah = Customer.create!(first_name: 'Mariah', last_name: 'Toy')
            @leanne = Customer.create!(first_name: 'Leanne', last_name: 'Kuhn')
            @sylvester = Customer.create!(first_name: 'Sylvester', last_name: 'Braund')
            @heber = Customer.create!(first_name: 'Heber', last_name: 'Nader')
            @dejon = Customer.create!(first_name: 'Dejob', last_name: 'Hoppe')
            @logan = Customer.create!(first_name: 'Logan', last_name: 'Jenkins')

            @invoice_1 = @joey.invoices.create!()
            @invoice_2 = @joey.invoices.create!(status: 2)
            @invoice_3 = @cecelia.invoices.create!(status: 1)
            @invoice_4 = @mariah.invoices.create!()
            @invoice_5 = @leanne.invoices.create!()
            @invoice_6 = @sylvester.invoices.create!(status: 1)
            @invoice_7 = @heber.invoices.create!()
            @invoice_8 = @dejon.invoices.create!()
            @invoice_9 = @logan.invoices.create!()

            @merchant_1 = Merchant.create!(name: "Schroeder-Jerde")
            @merchant_2 = Merchant.create!(name: "Klein, Rempel and Jones")

            @item_1 = @merchant_1.items.create!(name: "Qui Esse", description: "Nihil autem sit odio inventore deleniti. Est laudantium ratione distincti", unit_price: 75107)
            @item_2 = @merchant_1.items.create!(name: "Autem Minima", description: "Sunt officia eum qui molestiae. Nesciunt quidem cupiditate reiciendis est commodi non.", unit_price: 67076)
            @item_3 = @merchant_1.items.create!(name: "Ea Voluptatum", description: "Voluptate aut labore qui illum tempore eius. Corrupti cum et rerum. Enim illum labore voluptatem dicta consequatur. Consequatur sunt consequuntur ut officiis.", unit_price: 32301)
            @item_4 = @merchant_1.items.create!(name: "Nemo Facere", description: "Numquam officiis reprehenderit eum ratione neque tenetur. Officia aut repudiandae eum at ipsum doloribus. Iure minus itaque similique. Ratione dicta alias", unit_price: 15925)
            @item_5 = @merchant_1.items.create!(name: "Expedita Aliquam", description: "Reprehenderit est officiis cupiditate quia eos. Voluptatem illum reprehenderit quo vel eligendi. Et eum omnis id ut aliquid veniam.", unit_price: 31163)
            @item_6 = @merchant_1.items.create!(name: "Provident At", description: "Reiciendis sed aperiam culpa animi laudantium. Eligendi veritatis sint dolorem asperiores. Earum alias illum eos non rerum.", unit_price: 22582)
            @item_7 = @merchant_2.items.create!(name: "Expedita Fuga", description: "Voluptatibus omnis quo recusandae distinctio voluptatem quibusdam et. Voluptas odio accusamus delectus sunt quia. Non atque rerum vitae officia odit.", unit_price: 42629)

            @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 5, unit_price: 70000, status: 0)
            @invoice_item_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 6, unit_price: 69000, status: 1)
            @invoice_item_3 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_3.id, quantity: 5, unit_price: 32000, status: 2)
            @invoice_item_4 = InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_4.id, quantity: 5, unit_price: 16000, status: 0)
            @invoice_item_5 = InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_5.id, quantity: 5, unit_price: 19000, status: 1)
            @invoice_item_6 = InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_6.id, quantity: 7, unit_price: 30000, status: 2)
            @invoice_item_7 = InvoiceItem.create!(item_id: @item_6.id, invoice_id: @invoice_7.id, quantity: 3, unit_price: 20000, status: 0)
            @invoice_item_8 = InvoiceItem.create!(item_id: @item_7.id, invoice_id: @invoice_8.id, quantity: 7, unit_price: 45000, status: 1)
            @invoice_item_9 = InvoiceItem.create!(item_id: @item_7.id, invoice_id: @invoice_9.id, quantity: 4, unit_price: 56000, status: 1)

            @transaction_1 = @invoice_1.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: "04/27", result: "success")
            @transaction_2 = @invoice_1.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: "04/27", result: "success")
            @transaction_3 = @invoice_1.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: "04/27", result: "failed")
            @transaction_4 = @invoice_2.transactions.create!(credit_card_number: 4515551623735607, credit_card_expiration_date: "04/27", result: "success")
            @transaction_5 = @invoice_2.transactions.create!(credit_card_number: 4515551623735607, credit_card_expiration_date: "04/27", result: "failed")
            @transaction_6 = @invoice_3.transactions.create!(credit_card_number: 4536896898764278, credit_card_expiration_date: "04/27", result: "success")
            @transaction_7 = @invoice_3.transactions.create!(credit_card_number: 4536896898764278, credit_card_expiration_date: "04/27", result: "success")
            @transaction_8 = @invoice_4.transactions.create!(credit_card_number: 4252153331154380, credit_card_expiration_date: "04/27", result: "failed")
            @transaction_9 = @invoice_5.transactions.create!(credit_card_number: 4536896898764278, credit_card_expiration_date: "04/27", result: "success")
            @transaction_10 = @invoice_5.transactions.create!(credit_card_number: 4332881798016631, credit_card_expiration_date: "04/27", result: "success")
            @transaction_11 = @invoice_6.transactions.create!(credit_card_number: 4920121630073678, credit_card_expiration_date: "04/27", result: "success")
            @transaction_12 = @invoice_7.transactions.create!(credit_card_number: 4084466070588807, credit_card_expiration_date: "04/27", result: "success")
            @transaction_13 = @invoice_7.transactions.create!(credit_card_number: 4084466070588807, credit_card_expiration_date: "04/27", result: "success")
            @transaction_14 = @invoice_8.transactions.create!(credit_card_number: 4993984512460266, credit_card_expiration_date: "04/27", result: "success")
            @transaction_15 = @invoice_8.transactions.create!(credit_card_number: 4993984512460266, credit_card_expiration_date: "04/27", result: "failed")
            @transaction_16 = @invoice_9.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: "04/27", result: "success")
            @transaction_17 = @invoice_9.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: "04/27", result: "success")
            @transaction_17 = @invoice_9.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: "04/27", result: "success")
            @transaction_17 = @invoice_9.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: "04/27", result: "success")

            visit merchant_items_path(@merchant_1)

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
