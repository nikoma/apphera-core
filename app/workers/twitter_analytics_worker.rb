class TwitterAnalyticsWorker
  include Sidekiq::Worker

  #todo: make it less complicated - last 30 days every day, last 7 days, last day, mark range with id (then you can query by date and get the range you want)
  # query like: where range is 7 days and date is mm/dd/yy #create DateRange (last 7 days, 24 hours, last 30 days)
  # DateTime.now - x.days
  def perform(campaign_id, api_partner_id, analytics_range_id)
    analytics_range = AnalyticsRange.find analytics_range_id
    Time.zone = "UTC"
    Chronic.time_class = Time.zone
    from = Chronic.parse analytics_range.from
    to = Chronic.parse analytics_range.to
    camp = Campaign.find campaign_id
    kws = camp.keywords unless camp.nil?
    newkeys = []
    kws.each do |k|
      keyw = k.name.gsub(' ', ' & ')
      newkeys << keyw
    end

    @kw = newkeys.join(' | ')
    sentiment_positive = Tweet.where("created_at >=? and created_at <=?", from,to).where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', '#{@kw}')").where("sentiment > ?", 0.0).count
    sentiment_neutral = Tweet.where("created_at >=? and created_at <=?", from,to).where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', '#{@kw}')").where("sentiment = 0").count
    sentiment_negative = Tweet.where("created_at >=? and created_at <=?", from,to).where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', '#{@kw}')").where("sentiment < ?", 0).count
    tweets_total =  Tweet.where("created_at >=? and created_at <=?", from,to).where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', '#{@kw}')").count
    tweets_per_day = Tweet.where("created_at >=? and created_at <=?", from,to).where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', '#{@kw}')").select('EXTRACT(DAY from created_at)').group('EXTRACT(DAY FROM created_at)').order('EXTRACT(DAY from created_at)').count
    tweets_average_per_day = tweets_per_day.values.inject{ |sum, el| sum + el }.to_f / tweets_per_day.size
    tweets_with_links = Tweet.where("created_at >=? and created_at <=?", from,to).where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', '#{@kw}')").where("created_at >=? and created_at <=?", from,to).where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', 'https | http')").count
    tweets_with_links_percentage = tweets_with_links.to_f/tweets_total * 100
    max_tweets_quantity = tweets_per_day.values.max
    tweets_period_high = tweets_per_day.select { |k, v| v == max_tweets_quantity }
    min_tweets_quantity = tweets_per_day.values.min
    tweets_period_low = tweets_per_day.select { |k, v| v == min_tweets_quantity }
    tweets_unique_authors = Tweet.where("created_at >=? and created_at <=?", from,to).where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', '#{@kw}')").distinct(:twitter_user_id).count
    tweets_retweets_total = Tweet.where("created_at >=? and created_at <=?", from,to).where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', '#{@kw}')").sum(:retweet_count)
    tweets_retweets_percentage = tweets_retweets_total.to_f/tweets_total * 100
    tweets_top_languages = Tweet.where("created_at >=? and created_at <=?", from,to).where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', '#{@kw}')").group(:lang).count(:lang) #json
    # tweets_top_language = tweets_top_languages.values.inject{ |sum, el| sum + el }.to_f
    tweets_top_days_by_reach = Tweet.where("created_at >=? and created_at <=?", from,to).where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', '#{@kw}')").select('EXTRACT(DAY from created_at)').group('EXTRACT(DAY FROM created_at)').order('EXTRACT(DAY from created_at)').sum(:followers_count)
    tweets_top_mentions = 0
    tweets_top_influencers = 0

    results = { "sentiment_positive" => sentiment_positive, "sentiment_neutral" => sentiment_neutral, "sentiment_negative" => sentiment_negative, "tweets_total" => tweets_total,
                "tweets_per_day" => tweets_per_day, "tweets_average_per_day" => tweets_average_per_day, "tweets_with_links" => tweets_with_links,"tweets_with_links_percentage" => tweets_with_links_percentage, "tweets_period_high" => tweets_period_high,
                "tweets_period_low" => tweets_period_low, "tweets_unique_authors" => tweets_unique_authors, "tweets_retweets_total" => tweets_retweets_total, "tweets_retweets_percentage" => tweets_retweets_percentage,
                "tweets_top_languages" => tweets_top_languages, "tweets_top_days_by_reach" => tweets_top_days_by_reach,
                "tweets_top_mentions" => tweets_top_mentions, "tweets_top_influencers" => tweets_top_influencers}

    TwitterAnalytic.create!(api_partner_id: api_partner_id, campaign_id: camp.id, from: from, to: to, results: results, analytics_range_id: analytics_range_id)

  end
end
# t.integer :api_partner_id
# t.integer :campaign_id
# t.datetime :from
# t.datetime :to
# t.json :results
# t.integer :analytics_range_id