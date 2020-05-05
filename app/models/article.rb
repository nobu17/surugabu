# frozen_string_literal: true

class Article < ApplicationRecord
  has_many :article_areas, dependent: :destroy
  has_many :areas, through: :article_areas
  has_many :article_categorys, dependent: :destroy
  has_many :categorys, through: :article_categorys

  validates :title, presence: true
  validates :sub_title, presence: true
  validates :content, presence: true
  validates :areas, presence: true
  validates :categorys, presence: true

  scope :search_article_by_id, lambda { |article_id|
    includes(:areas, :categorys).where(id: article_id).first
  }
  scope :search_by_page, lambda { |page|
    paginate(page: page, per_page: 3)
      .order(created_at: :desc)
  }
  scope :search_area_by_page, lambda { |area_id, page|
    joins(:areas)
      .where('areas.id = ?', area_id)
      .paginate(page: page, per_page: 3)
      .order(created_at: :desc)
  }
  scope :search_category_by_page, lambda { |category_id, page|
    joins(:categorys)
      .where('categories.id = ?', category_id)
      .paginate(page: page, per_page: 3)
      .order(created_at: :desc)
  }
  scope :search_area_category_by_page, lambda { |area_id, category_id, page|
    joins(:areas, :categorys)
      .where('(categories.id = ?) AND (areas.id = ?)', category_id, area_id)
      .paginate(page: page, per_page: 3)
      .order(created_at: :desc)
  }
end
