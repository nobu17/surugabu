# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :article_categorys
  has_many :aricles, through: :article_categorys

  validates :display_order, numericality: { only_integer: true, greater_than: 0, less_than: 999 }
  validates :name, presence: true
  validates :name, length: { minimum: 1, maximum: 10, too_long: '最大%{count}文字まで使えます' }

  scope :get_categorys_orderby_display_order, lambda {
    all.order(display_order: :asc)
  }

  def self.clear_cache
    Rails.cache.delete('cache_categorys')
  end

  def self.cached_all_categorys
    Rails.cache.fetch('cache_categorys', expired_in: 60.minutes) do
      # Area.all
      Category.all.order(display_order: :asc).to_a
    end
  end

end
