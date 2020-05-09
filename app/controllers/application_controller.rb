# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_common_info

  def set_common_info
    @all_areas = Area.get_areas_orderby_display_order
    @all_categorys = Category.get_categorys_orderby_display_order
  end
end
