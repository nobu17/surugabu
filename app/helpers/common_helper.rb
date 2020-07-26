# frozen_string_literal: true

module CommonHelper
  def image_with_default(image)
    if image.present? && image.attached?
      image_tag(image)
    else
      image_tag('no-image.png')
    end
  end

  def display_image(image, width = 400)
    if image.present? && image.attached?
      image_tag(image, width: width)
    else
      image_tag('no-image.png', width: width)
    end
  end

  def image_tag_with_default(image, option = { width: 400 })
    if image.present?
      image_tag(image, option)
    else
      image_tag('no-image.png', option)
    end
  end
end
