# frozen_string_literal: true

class Attachment < ApplicationRecord
  has_one_attached :image
end
