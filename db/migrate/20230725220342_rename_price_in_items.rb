class RenamePriceInItems < ActiveRecord::Migration[7.0]
  def change
    rename_column :items, :price, :unit_price
  end
end
