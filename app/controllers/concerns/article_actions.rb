# frozen_string_literal: true

module ArticleActions
  extend ActiveSupport::Concern

  def set_articles
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
    # puts @articles.inspect
    # end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    # @article = Article.includes(:areas, :categorys).where(id: params[:id]).first
    @article = Article.search_article_by_id(params[:id])
    puts @article.inspect
    if @article.nil?
      puts 'no existed'
    else
      @areas = @article.areas
      puts @areas.inspect
      @categorys = @article.categorys
      # puts @categorys.inspect
    end
    puts 'article:!!!!!!!!' + @article.inspect
    # @article = Article.find_by(id: params[:id], include: %i[areas categorys])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_only_article
    unless params[:id].nil?
      @article = Article.search_article_by_id(params[:id])
    end

    puts @article.inspect
    puts 'no existed' if @article.nil?
    # @article = Article.find_by(id: params[:id], include: %i[areas categorys])
  end
end
