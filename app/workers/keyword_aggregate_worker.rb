class KeywordAggregateWorker
  include Sidekiq::Worker

  def perform(id)
    kw = Keyword.find id
    @kw = kw.name.gsub(' ', ' & ') unless kw.name.include? "&"
    tweets_total = Tweet.where("to_tsvector('english', body->>'text') @@ to_tsquery('english', '#{@kw}')").count
    facebook_total = FacebookItem.where(keyword_id: kw.id).count
    instagram_total = InstagramItem.where(keyword_id: kw.id).count
    youtube_total = YoutubeVideo.where(keyword_id: kw.id).count
    twitter_followers_total = 2342

    aggregates = {"tweets_total" => tweets_total, "facebook_total" => facebook_total, "instagram_total" => instagram_total, "youtube_total" => youtube_total,
                  "twitter_followers_total" => twitter_followers_total}
    KeywordAggregate.create!(keyword_id: kw.id, aggregates: aggregates)
  end
end