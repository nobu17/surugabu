# frozen_string_literal: true

class Article < ApplicationRecord
  ITEM_NUMER_OF_PAGE = 10

  enum status: { open: 0, draft: 1 }

  has_many :article_areas, dependent: :destroy
  has_many :areas, through: :article_areas
  has_many :article_categorys, dependent: :destroy
  has_many :categorys, through: :article_categorys

  has_one_attached :title_image
  has_many_attached :content_images

  validates :title, presence: true
  validates :title, length: { minimum: 1, maximum: 20, too_long: '最大%{count}文字まで使えます' }
  validates :sub_title, presence: true
  validates :sub_title, length: { minimum: 1, maximum: 50, too_long: '最大%{count}文字まで使えます' }
  validates :content, presence: true
  validates :areas, presence: true
  validates :categorys, presence: true

  def title_image_thumbnail
    if title_image.attached?
      title_image.variant(resize_to_fill: [200, 200]).processed
    end
  end

  def title_image_compressed
    if title_image.attached?
      title_image.variant(resize_to_fill: [680, 480]).processed
    end
  end

  scope :search_article_by_id, lambda { |article_id|
    includes(:areas, :categorys).where(id: article_id).first
  }
  scope :search_edit_article_by_page, lambda { |page|
    paginate(page: page, per_page: ITEM_NUMER_OF_PAGE)
      .order(created_at: :desc)
  }
  scope :search_by_page, lambda { |page|
    where(status: 0)
      .paginate(page: page, per_page: ITEM_NUMER_OF_PAGE)
      .order(created_at: :desc)
  }
  scope :search_area_by_page, lambda { |area_id, page|
    where(status: 0)
      .joins(:areas)
      .where('areas.id = ?', area_id)
      .paginate(page: page, per_page: ITEM_NUMER_OF_PAGE)
      .order(created_at: :desc)
  }
  scope :search_category_by_page, lambda { |category_id, page|
    where(status: 0)
      .joins(:categorys)
      .where('categories.id = ?', category_id)
      .paginate(page: page, per_page: ITEM_NUMER_OF_PAGE)
      .order(created_at: :desc)
  }
  scope :search_area_category_by_page, lambda { |area_id, category_id, page|
    where(status: 0)
      .joins(:areas, :categorys)
      .where('(categories.id = ?) AND (areas.id = ?)', category_id, area_id)
      .paginate(page: page, per_page: ITEM_NUMER_OF_PAGE)
      .order(created_at: :desc)
  }
  scope :search_areas_categorys, lambda { |area_ids, category_ids, self_id|
    where(status: 0)
      .joins(:areas, :categorys)
      .where('(categories.id IN (?)) OR (areas.id IN (?))', category_ids, area_ids)
      .where.not(id: self_id)
      .order(created_at: :desc)
      .limit(5)
  }
end
