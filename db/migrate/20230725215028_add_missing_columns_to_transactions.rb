class AddMissingColumnsToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :credit_card_number, :bigint
    add_column :transactions, :credit_card_expiration_date, :string
  end
end
