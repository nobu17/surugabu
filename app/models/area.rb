# frozen_string_literal: true

class Area < ApplicationRecord
  has_many :article_areas
  has_many :aricles, through: :article_areas

  validates :display_order, numericality: { only_integer: true, greater_than: 0, less_than: 999  }

  scope :get_areas_orderby_display_order, lambda {
    all.order(display_order: :desc)
  }
end
