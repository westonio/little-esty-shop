class UpdateStatusColumnInInvoices < ActiveRecord::Migration[7.0]
  def change
    change_column :invoices, :status, :integer, default: 0
  end
end
