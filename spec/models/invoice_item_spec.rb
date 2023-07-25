require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'Associations' do
    it { should belong_to :invoice }
    it { should belong_to :item }
  end

  describe 'Validations' do
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :status }
    it { should define_enum_for(:status).with([:pending, :packaged, :shipped]) }
  end

  describe 'Instance Methods' do
    
  end
end