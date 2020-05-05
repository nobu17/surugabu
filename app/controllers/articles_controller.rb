# frozen_string_literal: true

# Artcile controller
class ArticlesController < ApplicationController
  include ArticleActions
  before_action :set_article, only: [:show]

  # GET /article/
  # GET /article/pages/:page
  # GET /article/pages/:page?area=x&category=y
  def index
    area = params[:area]
    category = params[:category]

    @articles = if !area.nil? && !category.nil?
                  Article.search_area_category_by_page(1, 1, params[:page])
                elsif !area.nil?
                  Article.search_area_by_page(area, params[:page])
                elsif !category.nil?
                  Article.search_category_by_page(category, params[:page])
                else
                  Article.search_by_page(params[:page])
                end

    # @articles = Article.search_area_category_by_page(1, 1, params[:page])
    puts @articles.inspect
    # end
  end

  # GET /article/1
  def show
    # redirect_to :controller => 'home', :action => 'index'
    redirect_to controller: 'home', action: 'index' unless @article.present?
  end

  private

  # Only allow a list of trusted parameters through.
  def arcile_params
    params.require(:article).permit(:id)
  end
end
