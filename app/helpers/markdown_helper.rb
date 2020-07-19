# frozen_string_literal: true

class CustomRenderer < Redcarpet::Render::HTML
  include ActionView::Helpers::AssetTagHelper

  def image(link, title, alt_text)
    image_tag(link, title: title, alt: alt_text, loading: 'lazy%')
  end
end

module MarkdownHelper
  def markdown_to_html(text)
    options = {
      filter_html: false,
      hard_wrap: true,
      space_after_headers: false
    }

    extensions = {
      autolink: true,
      tables: true,
      no_intra_emphasis: false,
      fenced_code_blocks: false
    }
    renderer = CustomRenderer.new(options)
    # renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end
end
