# frozen_string_literal: true

class MapController < ApplicationController
  def index; end

  # GET map/all
  def all
    data = Article.cached_all_maps
    render json: { data: data }
  end
end
