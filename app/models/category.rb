# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :article_categorys
  has_many :aricles, through: :article_categorys
end
