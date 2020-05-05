# frozen_string_literal: true

class Area < ApplicationRecord
  has_many :article_areas
  has_many :aricles, through: :article_areas
end
