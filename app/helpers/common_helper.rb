# frozen_string_literal: true

module CommonHelper
  def display_image(image)
    if image.attached?
      image_tag(image)
    else
      image_tag('no-image.png')
    end
  end
end
