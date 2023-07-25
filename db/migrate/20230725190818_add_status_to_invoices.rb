class AddStatusToInvoices < ActiveRecord::Migration[7.0]
  def change
    add_column :invoices, :status, :enum, enum_type: :integer
  end
end
