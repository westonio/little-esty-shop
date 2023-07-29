class Customer < ApplicationRecord
  has_many :invoices

  validates_presence_of :first_name, :last_name

  def self.top_five_with_most_success_transactions
    Customer.select("first_name, last_name, count(result)")
      .joins(invoices: :transactions)
      .where(transactions: { result: "success" })
      .group(:first_name, :last_name)
      .order("count DESC")
      .limit(5)
  end
end