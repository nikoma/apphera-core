class CampaignAnalyticsWorker
  include Sidekiq::Worker
  def perform(account_id, date_range_id)
    # account_id = 1; date_range_id = 2
    @account = Account.find account_id
    @campaigns = @account.campaigns
    date_range = DateRange.find date_range_id # DateRange like "7.days.ago.midnight" which then gets turned into datetime by evaluating the expression
    from = eval(date_range.from)
    to = eval(date_range.to)

    @campaigns.each do |campaign|
      total_posts = 0 # all posts in a campaign (tweets, facebook etc.)
      total_posts_by_source = {} # all posts by source
      total_posts_by_source["facebook"] = 0
      total_posts_by_source["youtube"] = 0
      total_posts_by_source["instagram"] = 0
      total_posts_by_source["twitter"] = 0
      posts_per_day_by_source = {}
      average_posts = 0 #average posts
      top_day_by_count = Date.today # highest posts count on a given day in the query period
      period_high = 0 # highest count in date range
      period_low = 0 # lowest count in date range
      top_influencers = {}
      sentiments = {}
      sentiments["positive"] = 345 # TODO: count of positive sentiments in date range
      sentiments["negative"] = 123 # TODO: count negative
      sentiments["neutral"] = 4567 # TODO: count neutral
      top_posts = {} # TODO: top posts by reach - example - twitter followers
      unique_authors = 0 # unique authors of all posts
      sentiment_percentage = {} # sentiment distribution over time frame

      results = {}
      campaign.keywords.each do |keyword|
      kw = keyword.name.split(' ').first
      total_posts_by_source["facebook"] = total_posts_by_source["facebook"] + keyword.facebook_items.where("created_at >=? and created_at <=?", from,to).count || 0
      total_posts_by_source["youtube"] = total_posts_by_source["youtube"] + keyword.youtube_videos.where("created_at >=? and created_at <=?", from,to).count || 0
      total_posts_by_source["instagram"] = total_posts_by_source["instagram"] + keyword.instagram_items.where("created_at >=? and created_at <=?", from,to).count || 0
      total_posts_by_source["twitter"] = total_posts_by_source["twitter"] + Tweet.where("created_at >=? and created_at <=?", from,to).where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', '#{kw}')").count || 0

      # todo: posts_per_day_by_source need to be summed up as well for the campaign
      posts_per_day_by_source["facebook"] = keyword.facebook_items.where("created_at >=? and created_at <=?", from, to).select('EXTRACT(DAY from created_at)').group('EXTRACT(DAY FROM created_at)').order('EXTRACT(DAY from created_at)').count
      @fb_average_per_day = posts_per_day_by_source["facebook"].values.inject{ |sum, el| sum + el }.to_f / posts_per_day_by_source["facebook"].size || 0
      posts_per_day_by_source["youtube"] = keyword.youtube_videos.where("created_at >=? and created_at <=?", from, to).select('EXTRACT(DAY from created_at)').group('EXTRACT(DAY FROM created_at)').order('EXTRACT(DAY from created_at)').count
      @you_average_per_day = posts_per_day_by_source["youtube"].values.inject{ |sum, el| sum + el }.to_f / posts_per_day_by_source["youtube"].size || 0
      posts_per_day_by_source["instagram"] = keyword.instagram_items.where("created_at >=? and created_at <=?", from, to).select('EXTRACT(DAY from created_at)').group('EXTRACT(DAY FROM created_at)').order('EXTRACT(DAY from created_at)').count
      @insta_average_per_day = posts_per_day_by_source["instagram"].values.inject{ |sum, el| sum + el }.to_f / posts_per_day_by_source["instagram"].size || 0
      posts_per_day_by_source["twitter"] = Tweet.where("created_at >=? and created_at <=?", from,to).where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', '#{kw}')").select('EXTRACT(DAY from created_at)').group('EXTRACT(DAY FROM created_at)').order('EXTRACT(DAY from created_at)').count
      @twitter_average_per_day = posts_per_day_by_source["twitter"].values.inject{ |sum, el| sum + el }.to_f / posts_per_day_by_source["twitter"].size || 0
      max_tweets_quantity = posts_per_day_by_source["twitter"].values.max
      @tweets_period_high = posts_per_day_by_source["twitter"].select { |k, v| v == max_tweets_quantity }
      min_tweets_quantity = posts_per_day_by_source["twitter"].values.min
      @tweets_period_low = posts_per_day_by_source["twitter"].select { |k, v| v == min_tweets_quantity }
      end
      average_posts = (@fb_average_per_day + @you_average_per_day + @insta_average_per_day + @twitter_average_per_day)/4
      total_posts_by_source.each do |k,v|
        total_posts = total_posts + v
      end
      # todo: total_posts is wrong, some values hard-coded
      result = {"total_posts" => total_posts, "total_posts_by_source" => total_posts_by_source,"posts_per_day_by_source" => posts_per_day_by_source,
                "average_posts" => average_posts, "period_high" => @tweets_period_high, "period_low" => @tweets_period_low, "top_incluencers" => top_influencers,
      "top_posts" => top_posts, "unique_authors" => total_posts, "sentiments" => sentiments, "top_influencers" => top_influencers }
      AnalyticsResult.create!(account_id: account_id, campaign_id: campaign.id, date_range_id: date_range_id, results: result )
    end


  end
end

# final record should store the campaign id, account_id, date_range_id,


#string = '{"top_influencers":{"twitter":[234234,45345345,234234234,33445345345],
#"facebook":[345345,234234234,2323423],"youtube":[342534,3451445,534245]},
#"total_posts" : 345, "average_posts" : 234, "top_day_count" : 2341,
#"period_high" : 1231, "period_low" : 12, "unique_authors" :1231, "sentiment_positive" : 234,
# "sentiment_negative" : 232, "sentiment_neutral" : 23, "top_posts":{"twitter":[234234,45345345,234234234,33445345345],
# "facebook":[345345,234234234,2323423],"youtube":[342534,3451445,534245]}}'
