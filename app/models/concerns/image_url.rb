# frozen_string_literal: true

module Concerns
  module ImageUrl
    extend ActiveSupport::Concern
    include Rails.application.routes.url_helpers

    included do
      Rails.application.routes.default_url_options[:host] = 'surugabu.com'
    end
  end
end
