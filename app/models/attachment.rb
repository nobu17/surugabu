# frozen_string_literal: true

class Attachment < ApplicationRecord
  has_one_attached :image

  def image_compressed
    if image.attached?
      image.variant(resize_to_fit: [1024, 1024]).processed
    end
  end
end
