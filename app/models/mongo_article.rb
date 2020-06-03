# frozen_string_literal: true

class MongoArticle
  include Mongoid::Document
  include Mongoid::Timestamps
  field :article_id, type: String
  field :access_count, type: Integer
  embeds_many :mongo_comments, cascade_callbacks: true

  index(article_id: 1)

  scope :get_orderby_access_count, lambda {
    all.order(access_count: :asc)
  }

  def self.increment_access_count(article_id)
    mongo_article = MongoArticle.find_or_create_by(article_id: article_id)
    if mongo_article.access_count.nil?
      mongo_article.access_count = 1
    else
      mongo_article.access_count += 1
    end
    mongo_article.save
  end
end
