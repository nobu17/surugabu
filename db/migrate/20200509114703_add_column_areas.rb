# frozen_string_literal: true

class AddColumnAreas < ActiveRecord::Migration[6.0]
  def change
    add_column :areas, :display_order, :integer
  end
end
