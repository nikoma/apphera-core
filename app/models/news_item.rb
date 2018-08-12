class NewsItem < ActiveRecord::Base
  belongs_to :keyword
  #attr_accessible :keyword_id, :market_id, :body
end
