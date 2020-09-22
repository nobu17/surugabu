# frozen_string_literal: true

class Article < ApplicationRecord
  include Rails.application.routes.url_helpers
  ITEM_NUMER_OF_PAGE = 6

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
  validates :latitude, presence: true
  validates :latitude, numericality: true
  validates :latitude, inclusion: { in: -90..90, message: '緯度は-90~90の間で設定してください。' }
  validates :longitude, presence: true
  validates :longitude, numericality: true
  validates :longitude, inclusion: { in: -180..180, message: '経度は-90~90の間で設定してください。' }

  def title_image_thumbnail
    if title_image.attached?
      title_image.variant(resize_to_fill: [200, 200]).processed
    end
  end

  def meta_title
    "#{title}｜#{sub_title}"
  end

  def title_image_compressed
    title_image
    # if title_image.attached?
    #   title_image.variant(resize_to_fill: [680, 480]).processed
    # end
  end

  def title_image_compressed_ogp_url
    # this can get not permanent url
    helpers = Rails.application.routes.url_helpers
    helpers.rails_representation_url(title_image, only_path: true)
  end

  def title_image_compressed_url
    if title_image.attached?
      Rails.application.routes.default_url_options[:host] = 'surugabu.com'
      url_for(title_image_compressed)
    else
      ''
    end
  end

  def self.clear_all_cache
    Rails.cache.delete('cache_maps')
    # delete page cache
    Rails.cache.delete_matched('*_page_cache')
  end

  def self.cached_all_maps
    Rails.cache.fetch('cache_maps', expired_in: 60.minutes) do
      # Area.all
      Article.find_map_data.to_a
    end
  end

  def self.cached_page(page)
    key = page.to_s + '_page_cache'
    Rails.cache.fetch(key, expired_in: 60.minutes) do
      puts 'start store page:' + key
      Article.search_by_page(page).to_a
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
  scope :find_map_data, lambda {
    where.not(longitude: 0, latitude: 0, status: 1)
         .as_json(only: %i[id title sub_title latitude longitude],
                  methods: :title_image_compressed_url,
                  include: [{ categorys: { only: %i[id name] } }])
  }
end
