# frozen_string_literal: true

class ArticleEditController < ApplicationController
  include ArticleActions
  before_action :authenticate_user!
  before_action :set_articles, only: [:index]
  before_action :set_article, only: [:edit]
  before_action :set_only_article, only: %i[update destroy]
  before_action :article_params, only: [:update]

  def index; end

  # GET admin/article_edit/1/edit
  def edit; end

  # GET admin/article_edit/new
  def new
    @article = Article.new
  end

  # POST admin/article_edit
  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to '/admin/article_edit', notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT admin/article_edit/1
  def update
    if @article.update(article_params)
      redirect_to '/admin/article_edit', notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE admin/article_edit/1
  def destroy
    @article.title_image.purge if @article.title_image.attached?
    @article.content_images.purge if @article.content_images.attached?
    @article.destroy
    redirect_to '/admin/article_edit', notice: 'Article was successfully deleted.'
  end

  private

  # Only allow a list of trusted parameters through.
  def article_params
    params.require(:article).permit(:title, :sub_title, :content, :title_image, content_images: [], area_ids: [], category_ids: [])
  end
end
