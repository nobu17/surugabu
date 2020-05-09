class AddColumnCategory < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :display_order, :integer, null: false, default: 1
  end
end
