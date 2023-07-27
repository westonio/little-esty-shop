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
    it 'concatenates its customers names' do
      joey = Customer.create!(first_name: 'Joey', last_name: 'Ondricka')
      invoice_1 = joey.invoices.create!()

      expect(invoice_1.customer_name).to eq("Joey Ondricka")
    end
  end
end