class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :invoice, null: false, foreign_key: true
      t.string :result

      t.timestamps
    end
  end
end
