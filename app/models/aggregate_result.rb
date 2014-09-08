class AggregateResult < ActiveRecord::Base
  belongs_to :organization
  store :competitor_results, accessors: [:cscore, :creviews, :creview_average, :cnegative_reviews, :cnegative_reviews_new, :cneutral_reviews, :cneutral_reviews_new, :cvideos, :cphotos, :ctweets, :ctweets_new, :cfb_likes, :cfb_likes_new, :cscore, :cfollowers, :cfollowing]

end
