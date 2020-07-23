# frozen_string_literal: true

class MapController < ApplicationController
  def index; end

  # GET map/all
  def all
    data = Article.find_map_data
    render json: { data: data }
  end
end
