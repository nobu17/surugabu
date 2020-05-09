# frozen_string_literal: true

class AboutController < ApplicationController
  include ArticleActions
  before_action :set_articles, only: [:index]

  def index; end
end
