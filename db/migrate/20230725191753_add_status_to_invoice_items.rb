class AddStatusToInvoiceItems < ActiveRecord::Migration[7.0]
  def change
    add_column :invoice_items, :status, :enum, enum_type: :integer
  end
end
