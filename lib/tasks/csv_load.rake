require 'csv'

namespace :csv_load do
  
  desc 'All'
  task all: [:customers, :invoices, :transactions, :merchants, :items, :invoice_items]

  desc 'Creates customers'
  task customers: :environment do
    CSV.read('./db/data/customers.csv', headers: true, header_converters: :symbol).map do |row|
      Customer.create(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!("customers")
  end

  desc 'Creates invoices'
  task invoices: :environment do
    CSV.read('./db/data/invoices.csv', headers: true, header_converters: :symbol).map do |row|
      Invoice.create(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!("invoices")
  end

  desc 'Creates transactions'
  task transactions: :environment do
    CSV.read('./db/data/transactions.csv', headers: true, header_converters: :symbol).map do |row|
      Transaction.create(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!("transactions")
  end

  desc 'Creates merchants'
  task merchants: :environment do
    CSV.read('./db/data/merchants.csv', headers: true, header_converters: :symbol).map do |row|
      Merchant.create(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!("merchants")
  end

  desc 'Creates items'
  task items: :environment do
    CSV.read('./db/data/items.csv', headers: true, header_converters: :symbol).map do |row|
      Item.create(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!("items")
  end

  desc 'Creates invoice items'
  task invoice_items: :environment do
    CSV.read('./db/data/invoice_items.csv', headers: true, header_converters: :symbol).map do |row|
      InvoiceItem.create(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!("invoice_items")
  end
end

# desc 'Creates all objects'
# task :all do
#   Rake::Task["customers"].invoke
#   Rake::Task["invoices"].invoke
#   Rake::Task["transactions"].invoke
#   Rake::Task["merchants"].invoke
#   Rake::Task["items"].invoke
#   Rake::Task["invoice_items"].invoke
# end