# frozen_string_literal: true

module CommonHelper
  def display_image(image, width = 400)
    if image.attached?
      image_tag(image, width: width)
    else
      image_tag('no-image.png', width: width)
    end
  end

  def image_tag_with_default(image, option = {})
    if image.present?
      image_tag(image, option)
    else
      image_tag('no-image.png', option)
    end
  end
end
