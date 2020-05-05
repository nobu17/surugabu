# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @articles = Article.all
    # puts @articles.inspect
  end
end
