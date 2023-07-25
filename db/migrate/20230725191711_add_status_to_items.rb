class AddStatusToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :status, :enum, enum_type: :integer
  end
end
