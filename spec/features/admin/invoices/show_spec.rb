require 'rails_helper'

RSpec.describe 'Admin Invoice Show Page', type: :feature do
  describe 'When I visit an admin invoice show page (/admin/invoices/:invoice_id)' do
    before :each do
      @joey = Customer.create!(first_name: 'Joey', last_name: 'Ondricka')
      @Cecelia = Customer.create!(first_name: 'Cecelia', last_name: 'Osinski')
      @Mariah = Customer.create!(first_name: 'Mariah', last_name: 'Toy')

      @invoice_1 = @joey.invoices.create!()
      @invoice_2 = @joey.invoices.create!(status: 2)
      @invoice_3 = @Cecelia.invoices.create!()
      @invoice_4 = @Mariah.invoices.create!()

      @merchant_1 = Merchant.create!(name: "Schroeder-Jerde")
      @merchant_2 = Merchant.create!(name: "Klein, Rempel and Jones")

      @item_1 = @merchant_1.items.create!(name: "Qui Esse", description: "Nihil autem sit odio inventore deleniti. Est laudantium ratione distincti", unit_price: 75107)
      @item_2 = @merchant_1.items.create!(name: "Autem Minima", description: "Sunt officia eum qui molestiae. Nesciunt quidem cupiditate reiciendis est commodi non.", unit_price: 67076)
      @item_3 = @merchant_1.items.create!(name: "Ea Voluptatum", description: "Voluptate aut labore qui illum tempore eius. Corrupti cum et rerum. Enim illum labore voluptatem dicta consequatur. Consequatur sunt consequuntur ut officiis.", unit_price: 32301)
      @item_4 = @merchant_1.items.create!(name: "Nemo Facere", description: "Numquam officiis reprehenderit eum ratione neque tenetur. Officia aut repudiandae eum at ipsum doloribus. Iure minus itaque similique. Ratione dicta alias", unit_price: 15925)
      @item_5 = @merchant_2.items.create!(name: "Expedita Aliquam", description: "Reprehenderit est officiis cupiditate quia eos. Voluptatem illum reprehenderit quo vel eligendi. Et eum omnis id ut aliquid veniam.", unit_price: 31163)
      @item_6 = @merchant_2.items.create!(name: "Provident At", description: "Reiciendis sed aperiam culpa animi laudantium. Eligendi veritatis sint dolorem asperiores. Earum alias illum eos non rerum.", unit_price: 22582)
      @item_7 = @merchant_2.items.create!(name: "Expedita Fuga", description: "Voluptatibus omnis quo recusandae distinctio voluptatem quibusdam et. Voluptas odio accusamus delectus sunt quia. Non atque rerum vitae officia odit.", unit_price: 42629)

      @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 5, unit_price: 70000, status: 0)
      @invoice_item_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_1.id, quantity: 6, unit_price: 69000, status: 1)
      @invoice_item_3 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_2.id, quantity: 5, unit_price: 32000, status: 2)
      @invoice_item_4 = InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_3.id, quantity: 5, unit_price: 16000, status: 0)
      @invoice_item_5 = InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_3.id, quantity: 5, unit_price: 19000, status: 1)
      @invoice_item_6 = InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_4.id, quantity: 7, unit_price: 30000, status: 2)
      @invoice_item_7 = InvoiceItem.create!(item_id: @item_6.id, invoice_id: @invoice_4.id, quantity: 3, unit_price: 20000, status: 0)
      @invoice_item_8 = InvoiceItem.create!(item_id: @item_7.id, invoice_id: @invoice_4.id, quantity: 7, unit_price: 45000, status: 1)

      visit admin_invoice_path(@invoice_1)
    end

    describe "I see information related to that invoice" do
      it "shows the invoice's ID" do
        expect(page).to have_content(@invoice_1.id, count: 1)
        expect(page).to_not have_content(@invoice_2.id)
      end

      it "shows the invoice's status" do
        expect(page).to have_content(@invoice_1.status.capitalize, count: 1)
        expect(page).to_not have_content(@invoice_2.status.capitalize)
      end

      it "shows the invoice's created_at date in the format 'Monday, July 18, 2019'" do
        expect(page).to have_content(Date.today.strftime('%A, %e %b %Y'), count: 1)
      end

      it "shows the invoice's Customer first and last name" do
        within("#invoice-customer-info") do
          expect(page).to have_content(@invoice_1.customer_name, count: 1)
          expect(page).to_not have_content(@invoice_3.customer.first_name)
        end
      end
    end

    describe "I see all of the items on the invoice " do
      it "shows each item's name" do
        within("#invoice-item-#{@invoice_item_1.id}") do
          expect(page).to have_content(@invoice_item_1.item.name, count: 1)
        end

        within("#invoice-item-#{@invoice_item_2.id}") do
          expect(page).to have_content(@invoice_item_2.item.name, count: 1)
        end

        expect(page).to_not have_content(@invoice_item_3.item.name)
        expect(page).to_not have_css("#invoice-item-#{@invoice_item_3.id}")
      end
      
      it "shows each item's quantity ordered" do
        within("#invoice-item-#{@invoice_item_1.id}") do
          expect(page).to have_content(@invoice_item_1.quantity)
        end

        within("#invoice-item-#{@invoice_item_2.id}") do
          expect(page).to have_content(@invoice_item_2.quantity)
        end
      end

      it "shows each item's unit price it was sold for" do
        within("#invoice-item-#{@invoice_item_1.id}") do
          expect(page).to have_content(@invoice_item_1.unit_price, count: 1)
        end

        within("#invoice-item-#{@invoice_item_2.id}") do
          expect(page).to have_content(@invoice_item_2.unit_price, count: 1)
        end
      end

      it "shows each item's invoice_item status" do
        within("#invoice-item-#{@invoice_item_1.id}") do
          expect(page).to have_content(@invoice_item_1.status, count: 1)
        end

        within("#invoice-item-#{@invoice_item_2.id}") do
          expect(page).to have_content(@invoice_item_2.status, count: 1)
        end
      end
    end
  end
end