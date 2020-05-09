class ChangeColumnAreas < ActiveRecord::Migration[6.0]
  def change
    change_column :areas, :display_order, :integer, null: false, default: 1
  end
end
