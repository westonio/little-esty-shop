class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name, :description, :unit_price, :description, :status

  enum :status, { 'disabled' => 0, 'enabled' => 1 }
end

def self.item_revenue
  where(merchant_id: merchant.id).sum('unit_price')
end
