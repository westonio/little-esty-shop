class Merchant < ApplicationRecord
  has_many :items

  validates_presence_of :name, :status

  enum :status, { "enabled" => 0, "disabled" => 1 }

  def invoices
    Invoice.joins(items: :merchant).where(items: { merchant: self }).distinct
  end
end
