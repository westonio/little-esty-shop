class Merchant < ApplicationRecord
  has_many :items

  validates_presence_of :name

  def invoices
    Invoice.joins(items: :merchant).where(items: { merchant: self }).distinct
  end
end
