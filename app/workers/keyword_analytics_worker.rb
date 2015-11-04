class KeywordAnalyticsWorker
  include Sidekiq::Worker

  #I just need to query all this from keywords and THEN do it for the campaign
  # what time frame? Hourly?

  def perform(kw_id, date_range)
    date_range = 7.days.ago
    kw = Keyword.find(kw_id)
    @kw = kw.name.gsub!(' ', ' & ')
    @kw = 'porsche' #todo: REMOVE ME
    # in the beginning also query empty tracks as its faster to do. iterate over items. add source amounts

    facebook_total = kw.facebook_items.where("created_at <= ?", date_range).count
    instagram_total = kw.instagram_items.where("created_at <= ?", date_range).count
    youtube_total_videos = kw.youtube_videos.where("created_at <= ?", date_range).count
    youtube_total_comments = 37 #todo: query comments
    total_posts = facebook_total + instagram_total + youtube_total_videos # calculate total keyword posts
    top_day_by_count = {"14"=> 46} # calculate best day keywords + sum
    period_high = {"12"=> 99} # number of posts from the highest day
    period_low = {"8"=> 11}
    unique_authors = total_posts # todo: fixme

    # come up with sentiment iterator or just do it when written (need to re-sentiment never less and be able to repeat it)
    # todo: run sentiment analysis on all posts
    sentiment_positive = 3451 # from keywords
    sentiment_neutral = 2321 #kw
    sentiment_negative = 121 #kw
    top_posts_per_day_by_reach = 0 #kw - use FB insights where available -> returns an array
    top_influencers = 0 #kw - returns an array by followers count by now? maybe klout - klout maybe fastest!!!
    # todo: get the twitter results from the twitter worker
    # # Twitter is rolled into the above and also seperate
    # tweets_total =  Tweet.where("created_at >=?", date_range).where("to_tsvector('english', body->>'text') @@ to_tsquery('english', '#{@kw}')").count
    # tweets_average_per_day = 0 #from keywords
    # tweets_with_links = 0 #percentage from keywords
    # tweets_period_high = 0 #from keywords
    # tweets_period_low = 0 #from keywords
    # tweets_unique_authors = 0 #from keywords
    # tweets_retweets = 0 #percentage kw
    # tweets_top_language = 0 #kw -> create array ordered by top language
    # tweets_top_day_by_reach = 0 #kw -> followers count
    # tweets_top_mentions = 0 #from keywords
    # tweets_top_influencers = 0 #kw -> friends (not very accurate)

  end
end



