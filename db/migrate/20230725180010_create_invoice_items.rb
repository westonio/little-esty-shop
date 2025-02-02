class CreateInvoiceItems < ActiveRecord::Migration[7.0]
  def change
    create_table :invoice_items do |t|
      t.references :items, null: false, foreign_key: true
      t.references :invoice, null: false, foreign_key: true
      t.integer :quantity
      t.integer :unit_price

      t.timestamps
    end
  end
end
