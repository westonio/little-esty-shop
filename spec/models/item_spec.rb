require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'Associations' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many :invoices }
  end

  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :status }
    it { should define_enum_for(:status).with_values(%w[disabled enabled]) }
  end

  describe 'Class Methods' do
    before :each do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @item1 = @merchant1.items.create!(name: 'Shampoo', description: 'This washes your hair', unit_price: 10,
                                        status: 0)
      @invoice1 = Customer.create!(first_name: 'Joey', last_name: 'Smith').invoices.create!(status: 1)
      InvoiceItem.create!(item: @item1, invoice: @invoice1, quantity: 1, unit_price: 10, status: 0)
    end

    it 'returns correct item revenue' do
      expect(Item.item_revenue(@merchant1.id)).to eq(10)
    end
  end
end
