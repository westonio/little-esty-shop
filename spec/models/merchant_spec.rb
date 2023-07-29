require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'Associations' do
    it { should have_many :items }
  end

  describe 'Validations' do
    it { should validate_presence_of :name }
  end

  describe 'Instance Methods' do
    before :each do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @merchant2 = Merchant.create!(name: 'Body Care')
      @customer1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      @customer2 = Customer.create!(first_name: 'Tom', last_name: 'Hanks')

      @item1 = @merchant1.items.create!(name: 'Shampoo', description: 'This washes your hair', unit_price: 10,
                                        status: 0)
      @item2 = @merchant2.items.create!(name: 'Lotion', description: 'This moisturizes your hands', unit_price: 20,
                                        status: 0)
      @invoice1 = @customer1.invoices.create!(status: 1)
      @invoice2 = @customer2.invoices.create!(status: 1)

      InvoiceItem.create!(item: @item1, invoice: @invoice1, quantity: 1, unit_price: 10, status: 0)
      InvoiceItem.create!(item: @item2, invoice: @invoice2, quantity: 1, unit_price: 20, status: 0)
    end

    it 'returns correct invoices for a merchant' do
      expect(@merchant1.invoices).to include(@invoice1)
      expect(@merchant1.invoices).not_to include(@invoice2)

      expect(@merchant2.invoices).to include(@invoice2)
      expect(@merchant2.invoices).not_to include(@invoice1)
    end

    it "returns favorite customers" do
      expect(@merchant1.favorite_customers.first).to eq()
    end
  end
end
