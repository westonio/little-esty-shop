require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'Associations' do
    it { should belong_to :invoice }
  end

  describe 'Validations' do
    it { should validate_presence_of :result }
  end

  describe 'Instance Methods' do
    
  end
end