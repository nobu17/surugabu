# frozen_string_literal: true

class ArticleAccessCountController < ApplicationController
  # skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, only: [:index]

  # GET /admin/article_access_count/
  def index
    @articles = MongoArticle.get_orderby_access_count
  end

  # PUT /article_access_count/1
  def increment
    puts params[:article_id]
    MongoArticle.increment_access_count(params[:article_id])
    # render nothing: true, status: 200
    render json: {}
  end
end
