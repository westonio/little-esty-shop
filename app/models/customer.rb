class Customer < ApplicationRecord
  has_many :invoices

  validates_presence_of :first_name, :last_name

  def self.top_five_with_most_success_transactions
    Customer.select("first_name, last_name, count(result) as transaction_count")
      .joins(invoices: :transactions)
      .where(transactions: { result: "success" })
      .group(:first_name, :last_name)
      .order("transaction_count DESC")
      .limit(5)
  end

  def self.all_incomplete_invoices
    Invoice.where(status: "in progress").order(:id).pluck(:id)
  end
end