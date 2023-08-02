class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name, :description, :unit_price, :description, :status

  enum :status, { 'disabled' => 0, 'enabled' => 1 }

  def top_revenue_by_day
    invoices.select("DATE(invoices.created_at) AS date, SUM(invoice_items.unit_price * invoice_items.quantity) AS total_revenue").joins(:transactions).joins(:invoice_items).where(transactions: {result: "success"}).group("date").order("total_revenue DESC").limit(1).first.date
  end
end

