require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'Associations' do
    it { should belong_to :customer }
    it { should have_many :invoice_items }
    it { should have_many :items }
    it { should have_many :transactions }
  end

  describe 'Validations' do
    it { should validate_presence_of :status }
    it { should define_enum_for(:status).with_values(["in progress", "cancelled", "completed"]) }
  end

  describe 'Instance Methods' do
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
    end

    it 'concatenates its customers names' do
      expect(@invoice_1.customer_name).to eq("Joey Ondricka")
    end

    it 'can calculate full revenue (in cents)' do
      expect(@invoice_1.total_revenue).to eq(764000)
      expect(@invoice_2.total_revenue).to eq(160000)
      expect(@invoice_3.total_revenue).to eq(175000)
      expect(@invoice_4.total_revenue).to eq(585000)
    end
  end
end