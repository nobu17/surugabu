# frozen_string_literal: true

class AddMapColumnArticles < ActiveRecord::Migration[6.0]
  def up
    add_column :articles, :latitude, :float, null: false, default: 0
    add_column :articles, :longitude, :float, null: false, default: 0
  end

  def down
    remove_column :articles, :latitude, :float
    remove_column :articles, :longitude, :float
  end
end
