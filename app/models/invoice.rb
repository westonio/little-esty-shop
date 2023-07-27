class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  validates_presence_of :status

  enum :status, { "in progress" => 0, "cancelled" => 1, "completed" => 2 }

  def customer_name
    "#{customer.first_name} #{customer.last_name}"
  end
end