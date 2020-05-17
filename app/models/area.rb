# frozen_string_literal: true

class Area < ApplicationRecord
  has_many :article_areas
  has_many :aricles, through: :article_areas

  validates :display_order, numericality: { only_integer: true, greater_than: 0, less_than: 999 }
  validates :name, presence: true
  validates :name, length: { minimum: 1, maximum: 10, too_long: '最大%{count}文字まで使えます' }

  scope :get_areas_orderby_display_order, lambda {
    all.order(display_order: :asc)
  }

  def self.clear_cache
    Rails.cache.delete('cache_areas')
  end

  def self.cached_all_areas
    Rails.cache.fetch('cache_areas', expired_in: 60.minutes) do
      # Area.all
      Area.all.order(display_order: :asc).to_a
    end
  end

end
