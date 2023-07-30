class Add < ActiveRecord::Migration[7.0]
  def change
    add_column :merchants, :status, :enum, enum_type: :integer, default: 0
  end
end
