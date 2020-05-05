class CreateArticleAreas < ActiveRecord::Migration[6.0]
  def change
    create_table :article_areas do |t|
      t.references :article, null: false, foreign_key: true
      t.references :area, null: false, foreign_key: true

      t.timestamps
    end
  end
end
