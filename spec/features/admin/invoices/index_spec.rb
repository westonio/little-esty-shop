require 'rails_helper'

RSpec.describe 'Admin Invoices Index Page', type: :feature do
  describe "When I visit the admin Invoices index (/admin/invoices)" do
    before :each do
      @joey = Customer.create!(first_name: 'Joey', last_name: 'Ondricka')
      @Cecelia = Customer.create!(first_name: 'Cecelia', last_name: 'Osinski')
      @Mariah = Customer.create!(first_name: 'Mariah', last_name: 'Toy')

      @invoice_1 = @joey.invoices.create!()
      @invoice_2 = @joey.invoices.create!()
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

      InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 5, unit_price: 70000, status: 0)
      InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_1.id, quantity: 6, unit_price: 69000, status: 0)
      InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_2.id, quantity: 5, unit_price: 32000, status: 0)
      InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_3.id, quantity: 5, unit_price: 16000, status: 0)
      InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_3.id, quantity: 5, unit_price: 19000, status: 0)
      InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_4.id, quantity: 7, unit_price: 30000, status: 0)
      InvoiceItem.create!(item_id: @item_6.id, invoice_id: @invoice_4.id, quantity: 3, unit_price: 20000, status: 0)
      InvoiceItem.create!(item_id: @item_7.id, invoice_id: @invoice_4.id, quantity: 7, unit_price: 45000, status: 0)

      visit admin_invoices_path
    end

    it "Has a list of all Invoice ids in the system" do
      expect(page).to have_css(".admin-invoices")
      
      expect(page).to have_content(@invoice_1.id, count: 1)
      expect(page).to have_content(@invoice_2.id, count: 1)
      expect(page).to have_content(@invoice_3.id, count: 1)
      expect(page).to have_content(@invoice_4.id, count: 1)
    end

    it "Each id links to the admin invoice show page" do
      expect(page).to have_link("Invoice ##{@invoice_1.id}", count: 1)
      expect(page).to have_link("Invoice ##{@invoice_2.id}", count: 1)
      expect(page).to have_link("Invoice ##{@invoice_3.id}", count: 1)
      expect(page).to have_link("Invoice ##{@invoice_4.id}", count: 1)
    end
  end
end