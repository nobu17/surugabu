# frozen_string_literal: true

class MongoComment
  include Mongoid::Document
  include Mongoid::Timestamps
  field :user_name, type: String
  field :comment, type: String
  embedded_in :mongo_article, inverse_of: :mongo_comments
end
