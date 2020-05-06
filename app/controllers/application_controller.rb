# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_common_info

  def set_common_info
    @all_areas = Area.all
    @all_categorys = Category.all
  end
end
