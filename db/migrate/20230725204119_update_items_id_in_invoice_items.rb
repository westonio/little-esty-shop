class UpdateItemsIdInInvoiceItems < ActiveRecord::Migration[7.0]
  def change
    rename_column :invoice_items, :items_id, :item_id
  end
end
