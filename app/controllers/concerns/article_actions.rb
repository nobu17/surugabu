# frozen_string_literal: true

module ArticleActions
  extend ActiveSupport::Concern

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    # @article = Article.includes(:areas, :categorys).where(id: params[:id]).first
    @article = Article.search_article_by_id(params[:id])
    puts @article.inspect
    if @article.nil?
      puts 'no existed'
    else
      @areas = @article.areas
      # puts @areas.inspect
      @categorys = @article.categorys
      # puts @categorys.inspect
    end
    # @article = Article.find_by(id: params[:id], include: %i[areas categorys])
  end
end
