class Merchant < ApplicationRecord
  has_many :items

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
end
# When I visit the admin merchants index (/admin/merchants)
# Then I see the names of the top 5 merchants by total revenue generated
# And I see that each merchant name links to the admin merchant show page for that merchant
# And I see the total revenue generated next to each merchant name

# Notes on Revenue Calculation:

# Only invoices with at least one successful transaction should count towards revenue
# Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
# Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)

# SELECT merchants.name, SUM(invoice_items.unit_price * invoice_items.quantity) AS total_revenue FROM "merchants" INNER JOIN "items" ON "items"."merchant_id" = "merchants"."id" INNER JOIN "invoice_items" ON "invoice_items"."item_id" = "items"."id" INNER JOIN "invoices" ON "invoices"."id" = "invoice_items"."invoice_id" INNER JOIN "transactions" ON "transactions"."invoice_id" = "invoices"."id" WHERE "transactions"."result" = 'success' GROUP BY "merchants"."id" ORDER BY total_revenue DESC LIMIT 5