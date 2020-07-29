# frozen_string_literal: true

# active sotrage. it will be deleted.
class Attachment < ApplicationRecord
  has_one_attached :image

  def image_compressed
    if image.attached?
      image.variant(resize_to_fit: [800, 600], quality: 100).processed
    end
  end
end

class ImageAttachment
  include ActiveModel::Model
  extend CarrierWave::Mount

  attr_accessor :image
  mount_uploader :image, ImageUploader

  def image_compressed
    image
  end

  def save(image)
    self.image.store!(image)
  end
end
