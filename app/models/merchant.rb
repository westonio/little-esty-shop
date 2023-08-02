class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items

  validates_presence_of :name, :status

  enum :status, { "disabled" => 0, "enabled" => 1 }

  def invoices
    Invoice.joins(items: :merchant).where(items: { merchant: self }).distinct
  end

  def favorite_customers
    ids = invoices.pluck(:id)
    Customer.select("first_name, last_name, count(result)").joins(invoices: :transactions).where(transactions: {result: "success"}).where(invoices: {id: ids}).order(count: :desc).group("first_name, last_name").limit(5)
  end

  def self.top_merchants
    Merchant.select('merchants.name, merchants.id, SUM(invoice_items.unit_price * invoice_items.quantity) AS total_revenue')
    .joins(items: { invoice_items: { invoice: :transactions } })
    .where(transactions: {result: "success"})
    .group('merchants.id')
    .order('total_revenue DESC')
    .limit(5)
  end

  def ready_to_ship
    invoice_ids = invoices.pluck(:id)
    Item.joins(invoices: :invoice_items)
                .where.not(invoice_items: { status: "shipped" })
                .where.not(invoices: { status: "cancelled" })
                .where(items: { status: "enabled" })
                .where(invoices: { id: invoice_ids })
                .distinct
  end
end

