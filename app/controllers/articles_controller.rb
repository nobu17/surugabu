# frozen_string_literal: true

# Artcile controller
class ArticlesController < ApplicationController
  include ArticleActions
  before_action :set_article, only: [:show]
  before_action :set_articles, only: [:index]

  # GET /article/
  # GET /article/pages/:page
  # GET /article/pages/:page?area=x&category=y
  def index
    # puts @articles.inspect
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
