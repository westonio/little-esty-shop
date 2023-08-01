class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items

  validates_presence_of :name, :status

  enum :status, { "enabled" => 0, "disabled" => 1 }

  def invoices
    Invoice.joins(items: :merchant).where(items: { merchant: self }).distinct
  end

  def favorite_customers
    ids = invoices.pluck(:id)
    Customer.select("first_name, last_name, count(result)").joins(invoices: :transactions).where(transactions: {result: "success"}).where(invoices: {id: ids}).order(count: :desc).group("first_name, last_name").limit(5)
  end

  def item_revenue
    success_ids = invoices.joins(:transactions).where(transactions: {result: "success"}).pluck(:id)
    Item.select('name, SUM(invoice_items.unit_price * invoice_items.quantity) AS total_revenue').joins(invoices: :invoice_items).where(invoices: {id: success_ids}).group(:name).order("total_revenue desc")
  end
end

