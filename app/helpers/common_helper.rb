# frozen_string_literal: true

module CommonHelper
  def display_image(image, width = 400)
    if image.attached?
      image_tag(image, width:width)
    else
      image_tag('no-image.png')
    end
  end
end
