module Api
  module V1
    class AnalyticsController < ApplicationController

      def index

        render :json => @current_user.accounts.where(id: params[:account_id]).first.named_queries

      end

      def timezones
        render :json => timezones_json
      end

      def create_analytics_range
        name = params[:analytics_range][:name]
        from = params[:analytics_range][:from]
        to = params[:analytics_range][:to]
        unless Chronic.parse from
          render :status => 422, :json => { :message => "could not parse from value"}
          return
        end
        unless Chronic.parse to
          render :status => 422, :json => { :message => "could not parse to value"}
          return
        end
         r = current_user.analytics_ranges.create!(name: name, from: from, to: to, api_partner_id: current_user.id)
         render :status => 200, :json => { message: "Created new range with id #{ r.id }. Based on today's date your range would look like this: from '#{Chronic.parse from}' to '#{Chronic.parse to}'. This system will always evaluate new dates when using this range. You named your parameters from: '#{r.from}', to: '#{r.to}' "}
      end

      def analytics_range
        render :json => current_user.analytics_ranges
      end

      def delete_range
        current_user.analytics_ranges.find(params[:range_id]).destroy
        render :status => 200, :json => { :message => "Range deleted"}
      end

      def create

        @account = @current_user.accounts.find(params[:account_id])
        @named_query = NamedQuery.create(params[:name_query])
        @named_query.account_id = @account.id
        @named_query.api_partner_id = @current_user.id
        @named_query.save

      end

      def query
        @account = @current_user.accounts.find(params[:account_id])
        @named_query = @account.named_query.find(params[:query_id])
        render :status => 200, :json => @named_query.query

      end

      def tweets_hourly_distribution
        Time.zone = params[:time_zone] || "UTC"
        Chronic.time_class = Time.zone
        from = Chronic.parse(params[:from])
        to = Chronic.parse(params[:to])
        if from.nil? or to.nil?
          render :status => 402, :json => {:message => "can't parse date"}
          return
        end
        @kw = Keyword.find(params[:keyword_id])
        best_hours = Tweet.where("created_at >=? and created_at <=?", from, to).where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', '#{@kw.name}')").select('EXTRACT(HOUR from created_at)').group('EXTRACT(HOUR FROM created_at)').order('EXTRACT(HOUR from created_at)').count
        render :json => best_hours
      end

      def keyword_analytics_worker
        @kw = Keyword.find(params[:keyword_id])

      end

      def twitter_campaign_calculations
        #campaign_id, api_partner_id, analytics_range_id
        account = current_user.accounts.find params[:account_id]
        campaigns = account.campaigns
        analytics_ranges = current_user.analytics_ranges
        campaigns.each do |c|
          analytics_ranges.each do |ar|
            TwitterAnalyticsWorker.perform_async(c.id, current_user.id, ar.id)
          end
        end
        render :status => 200, :json => { :message => "Calculations enqueued" }

      end

      def get_twitter_campaign_calculations

        account = current_user.accounts.find params[:account_id]
        campaign = account.campaigns.find params[:campaign_id]
        results = []
        ranges = current_user.analytics_ranges
        ranges.each do |r|
           results << r.twitter_analytics.last
        end


        render :json => results
      end

      def twitter_by_campaign_ad_hoc

        Time.zone = params[:time_zone] || "UTC"
        Chronic.time_class = Time.zone
        from = Chronic.parse(params[:from])
        to = Chronic.parse(params[:to])
        if from.nil? or to.nil?
          render :status => 402, :json => {:message => "can't parse date"}
          return
        end
        camp = Campaign.find params[:campaign_id]
        kws = camp.keywords
        newkeys = []
        kws.each do |k|
          keyw = k.name.gsub(' ', ' & ')
          newkeys << keyw
        end

        @kw = newkeys.join(' | ')

        sentiment_positive = Tweet.where("created_at >=? and created_at <=?", from, to).where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', '#{@kw}')").where("sentiment > ?", 0.0).count
        sentiment_neutral = Tweet.where("created_at >=? and created_at <=?", from, to).where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', '#{@kw}')").where("sentiment = 0").count
        sentiment_negative = Tweet.where("created_at >=? and created_at <=?", from, to).where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', '#{@kw}')").where("sentiment < ?", 0).count
        tweets_total = Tweet.where("created_at >=? and created_at <=?", from, to).where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', '#{@kw}')").count
        tweets_per_day = Tweet.where("created_at >=? and created_at <=?", from, to).where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', '#{@kw}')").select('EXTRACT(DAY from created_at)').group('EXTRACT(DAY FROM created_at)').order('EXTRACT(DAY from created_at)').count
        tweets_average_per_day = tweets_per_day.values.inject { |sum, el| sum + el }.to_f / tweets_per_day.size
        tweets_with_links = Tweet.where("created_at >=? and created_at <=?", from, to).where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', '#{@kw}')").where("created_at >=? and created_at <=?", from, to).where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', 'https | http')").count
        tweets_with_links_percentage = tweets_with_links.to_f/tweets_total * 100
        max_tweets_quantity = tweets_per_day.values.max
        tweets_period_high = tweets_per_day.select { |k, v| v == max_tweets_quantity }
        min_tweets_quantity = tweets_per_day.values.min
        tweets_period_low = tweets_per_day.select { |k, v| v == min_tweets_quantity }
        tweets_unique_authors = Tweet.where("created_at >=? and created_at <=?", from, to).where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', '#{@kw}')").distinct(:twitter_user_id).count
        tweets_retweets_total = Tweet.where("created_at >=? and created_at <=?", from, to).where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', '#{@kw}')").sum(:retweet_count)
        tweets_retweets_percentage = tweets_retweets_total.to_f/tweets_total * 100
        tweets_top_languages = Tweet.where("created_at >=? and created_at <=?", from, to).where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', '#{@kw}')").group(:lang).count(:lang) #json
        # tweets_top_language = tweets_top_languages.values.inject{ |sum, el| sum + el }.to_f
        tweets_top_days_by_reach = Tweet.where("created_at >=? and created_at <=?", from, to).where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', '#{@kw}')").select('EXTRACT(DAY from created_at)').group('EXTRACT(DAY FROM created_at)').order('EXTRACT(DAY from created_at)').sum(:followers_count)
        tweets_top_mentions = 0
        tweets_top_influencers = 0

        results = {"sentiment_positive" => sentiment_positive, "sentiment_neutral" => sentiment_neutral, "sentiment_negative" => sentiment_negative, "tweets_total" => tweets_total,
                   "tweets_per_day" => tweets_per_day, "tweets_average_per_day" => tweets_average_per_day, "tweets_with_links" => tweets_with_links, "tweets_with_links_percentage" => tweets_with_links_percentage, "tweets_period_high" => tweets_period_high,
                   "tweets_period_low" => tweets_period_low, "tweets_unique_authors" => tweets_unique_authors, "tweets_retweets_total" => tweets_retweets_total, "tweets_retweets_percentage" => tweets_retweets_percentage,
                   "tweets_top_languages" => tweets_top_languages, "tweets_top_days_by_reach" => tweets_top_days_by_reach,
                   "tweets_top_mentions" => tweets_top_mentions, "tweets_top_influencers" => tweets_top_influencers}

        render :json => results.to_json

      end


      def twitter_analytics_ad_hoc
        Time.zone = params[:time_zone] || "UTC"
        Chronic.time_class = Time.zone
        from = Chronic.parse(params[:from])
        to = Chronic.parse(params[:to])
        if from.nil? or to.nil?
          render :status => 402, :json => {:message => "can't parse date"}
          return
        end
        kw = Keyword.find(params[:keyword_id])
        @kw = kw.name.gsub(' ', ' & ')

        sentiment_positive = Tweet.where("created_at >=? and created_at <=?", from, to).where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', '#{@kw}')").where("sentiment > ?", 0.0).count
        sentiment_neutral = Tweet.where("created_at >=? and created_at <=?", from, to).where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', '#{@kw}')").where("sentiment = 0").count
        sentiment_negative = Tweet.where("created_at >=? and created_at <=?", from, to).where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', '#{@kw}')").where("sentiment < ?", 0).count
        tweets_total = Tweet.where("created_at >=? and created_at <=?", from, to).where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', '#{@kw}')").count
        tweets_per_day = Tweet.where("created_at >=? and created_at <=?", from, to).where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', '#{@kw}')").select('EXTRACT(DAY from created_at)').group('EXTRACT(DAY FROM created_at)').order('EXTRACT(DAY from created_at)').count
        tweets_average_per_day = tweets_per_day.values.inject { |sum, el| sum + el }.to_f / tweets_per_day.size
        tweets_with_links = Tweet.where("created_at >=? and created_at <=?", from, to).where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', '#{@kw}')").where("created_at >=? and created_at <=?", from, to).where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', 'href')").count
        tweets_with_links_percentage = tweets_with_links.to_f/tweets_total * 100
        max_tweets_quantity = tweets_per_day.values.max
        tweets_period_high = tweets_per_day.select { |k, v| v == max_tweets_quantity }
        min_tweets_quantity = tweets_per_day.values.min
        tweets_period_low = tweets_per_day.select { |k, v| v == min_tweets_quantity }
        tweets_unique_authors = Tweet.where("created_at >=? and created_at <=?", from, to).where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', '#{@kw}')").distinct(:twitter_user_id).count
        tweets_retweets_total = Tweet.where("created_at >=? and created_at <=?", from, to).where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', '#{@kw}')").sum(:retweet_count)
        tweets_retweets_percentage = tweets_retweets_total.to_f/tweets_total * 100
        tweets_top_languages = Tweet.where("created_at >=? and created_at <=?", from, to).where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', '#{@kw}')").group(:lang).count(:lang) #json
        # tweets_top_language = tweets_top_languages.values.inject{ |sum, el| sum + el }.to_f
        tweets_top_days_by_reach = Tweet.where("created_at >=? and created_at <=?", from, to).where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', '#{@kw}')").select('EXTRACT(DAY from created_at)').group('EXTRACT(DAY FROM created_at)').order('EXTRACT(DAY from created_at)').sum(:followers_count)
        tweets_top_mentions = 0
        tweets_top_influencers = 0

        results = {"sentiment_positive" => sentiment_positive, "sentiment_neutral" => sentiment_neutral, "sentiment_negative" => sentiment_negative, "tweets_total" => tweets_total,
                   "tweets_per_day" => tweets_per_day, "tweets_average_per_day" => tweets_average_per_day, "tweets_with_links" => tweets_with_links, "tweets_with_links_percentage" => tweets_with_links_percentage, "tweets_period_high" => tweets_period_high,
                   "tweets_period_low" => tweets_period_low, "tweets_unique_authors" => tweets_unique_authors, "tweets_retweets_total" => tweets_retweets_total, "tweets_retweets_percentage" => tweets_retweets_percentage,
                   "tweets_top_languages" => tweets_top_languages, "tweets_top_days_by_reach" => tweets_top_days_by_reach,
                   "tweets_top_mentions" => tweets_top_mentions, "tweets_top_influencers" => tweets_top_influencers}

        render :json => results.to_json

      end

      def keyword_analytics #stored results with params like 'last' 'week' etc.

      end

      def campaign_date_ranges
        ranges = DateRange.all
        render :json => ranges
      end

      def campaign_results
        @account = @current_user.accounts.find params[:account_id]
        @campaign = @account.campaigns.find params[:campaign_id]
        #date_range = DateRange.find params[:date_range]
        render :json => @campaign.analytics_results

      end
#       def campaign_results
#
#         # total_posts = 3452
#         # average_posts = 234
#         # top_day_count = DateTime.now
#         # period_high = 2341
#         # period_low = 4
#         # unique_authors = 231
#         # sentiment_positive = 123
#         # sentiment_neutral = 23
#         # sentiment_negative = 2
#         # top_posts = { :twitter => [234234,45345345,234234234,33445345345], :facebook => [345345,234234234,2323423], :youtube => [342534,3451445,534245]}
#         # top_influencers = { :twitter => [234234,45345345,234234234,33445345345], :facebook => [345345,234234234,2323423], :youtube => [342534,3451445,534245]}
#         #
#         # results = total_posts,
#         string = '{"top_influencers":{"twitter":[234234,45345345,234234234,33445345345],"facebook":[345345,234234234,2323423],"youtube":[342534,3451445,534245]},
# "total_posts" : 345, "average_posts" : 234, "top_day_count" : 2341, "period_high" : 1231, "period_low" : 12, "unique_authors" :1231, "sentiment_positive" : 234, "sentiment_negative" : 232, "sentiment_neutral" : 23, "top_posts":{"twitter":[234234,45345345,234234234,33445345345],"facebook":[345345,234234234,2323423],"youtube":[342534,3451445,534245]}}'
#
#         render :json => string.to_json
#       end

      def timezones_json
        t = {"International Date Line West" => "Pacific/Midway", "Midway Island" => "Pacific/Midway", "American Samoa" => "Pacific/Pago_Pago", "Hawaii" => "Pacific/Honolulu", "Alaska" => "America/Juneau", "Pacific Time (US & Canada)" => "America/Los_Angeles", "Tijuana" => "America/Tijuana", "Mountain Time (US & Canada)" => "America/Denver", "Arizona" => "America/Phoenix", "Chihuahua" => "America/Chihuahua", "Mazatlan" => "America/Mazatlan", "Central Time (US & Canada)" => "America/Chicago", "Saskatchewan" => "America/Regina", "Guadalajara" => "America/Mexico_City", "Mexico City" => "America/Mexico_City", "Monterrey" => "America/Monterrey", "Central America" => "America/Guatemala", "Eastern Time (US & Canada)" => "America/New_York", "Indiana (East)" => "America/Indiana/Indianapolis", "Bogota" => "America/Bogota", "Lima" => "America/Lima", "Quito" => "America/Lima", "Atlantic Time (Canada)" => "America/Halifax", "Caracas" => "America/Caracas", "La Paz" => "America/La_Paz", "Santiago" => "America/Santiago", "Newfoundland" => "America/St_Johns", "Brasilia" => "America/Sao_Paulo", "Buenos Aires" => "America/Argentina/Buenos_Aires", "Montevideo" => "America/Montevideo", "Georgetown" => "America/Guyana", "Greenland" => "America/Godthab", "Mid-Atlantic" => "Atlantic/South_Georgia", "Azores" => "Atlantic/Azores", "Cape Verde Is." => "Atlantic/Cape_Verde", "Dublin" => "Europe/Dublin", "Edinburgh" => "Europe/London", "Lisbon" => "Europe/Lisbon", "London" => "Europe/London", "Casablanca" => "Africa/Casablanca", "Monrovia" => "Africa/Monrovia", "UTC" => "Etc/UTC", "Belgrade" => "Europe/Belgrade", "Bratislava" => "Europe/Bratislava", "Budapest" => "Europe/Budapest", "Ljubljana" => "Europe/Ljubljana", "Prague" => "Europe/Prague", "Sarajevo" => "Europe/Sarajevo", "Skopje" => "Europe/Skopje", "Warsaw" => "Europe/Warsaw", "Zagreb" => "Europe/Zagreb", "Brussels" => "Europe/Brussels", "Copenhagen" => "Europe/Copenhagen", "Madrid" => "Europe/Madrid", "Paris" => "Europe/Paris", "Amsterdam" => "Europe/Amsterdam", "Berlin" => "Europe/Berlin", "Bern" => "Europe/Berlin", "Rome" => "Europe/Rome", "Stockholm" => "Europe/Stockholm", "Vienna" => "Europe/Vienna", "West Central Africa" => "Africa/Algiers", "Bucharest" => "Europe/Bucharest", "Cairo" => "Africa/Cairo", "Helsinki" => "Europe/Helsinki", "Kyiv" => "Europe/Kiev", "Riga" => "Europe/Riga", "Sofia" => "Europe/Sofia", "Tallinn" => "Europe/Tallinn", "Vilnius" => "Europe/Vilnius", "Athens" => "Europe/Athens", "Istanbul" => "Europe/Istanbul", "Minsk" => "Europe/Minsk", "Jerusalem" => "Asia/Jerusalem", "Harare" => "Africa/Harare", "Pretoria" => "Africa/Johannesburg", "Moscow" => "Europe/Moscow", "St. Petersburg" => "Europe/Moscow", "Volgograd" => "Europe/Moscow", "Kuwait" => "Asia/Kuwait", "Riyadh" => "Asia/Riyadh", "Nairobi" => "Africa/Nairobi", "Baghdad" => "Asia/Baghdad", "Tehran" => "Asia/Tehran", "Abu Dhabi" => "Asia/Muscat", "Muscat" => "Asia/Muscat", "Baku" => "Asia/Baku", "Tbilisi" => "Asia/Tbilisi", "Yerevan" => "Asia/Yerevan", "Kabul" => "Asia/Kabul", "Ekaterinburg" => "Asia/Yekaterinburg", "Islamabad" => "Asia/Karachi", "Karachi" => "Asia/Karachi", "Tashkent" => "Asia/Tashkent", "Chennai" => "Asia/Kolkata", "Kolkata" => "Asia/Kolkata", "Mumbai" => "Asia/Kolkata", "New Delhi" => "Asia/Kolkata", "Kathmandu" => "Asia/Kathmandu", "Astana" => "Asia/Dhaka", "Dhaka" => "Asia/Dhaka", "Sri Jayawardenepura" => "Asia/Colombo", "Almaty" => "Asia/Almaty", "Novosibirsk" => "Asia/Novosibirsk", "Rangoon" => "Asia/Rangoon", "Bangkok" => "Asia/Bangkok", "Hanoi" => "Asia/Bangkok", "Jakarta" => "Asia/Jakarta", "Krasnoyarsk" => "Asia/Krasnoyarsk", "Beijing" => "Asia/Shanghai", "Chongqing" => "Asia/Chongqing", "Hong Kong" => "Asia/Hong_Kong", "Urumqi" => "Asia/Urumqi", "Kuala Lumpur" => "Asia/Kuala_Lumpur", "Singapore" => "Asia/Singapore", "Taipei" => "Asia/Taipei", "Perth" => "Australia/Perth", "Irkutsk" => "Asia/Irkutsk", "Ulaanbaatar" => "Asia/Ulaanbaatar", "Seoul" => "Asia/Seoul", "Osaka" => "Asia/Tokyo", "Sapporo" => "Asia/Tokyo", "Tokyo" => "Asia/Tokyo", "Yakutsk" => "Asia/Yakutsk", "Darwin" => "Australia/Darwin", "Adelaide" => "Australia/Adelaide", "Canberra" => "Australia/Melbourne", "Melbourne" => "Australia/Melbourne", "Sydney" => "Australia/Sydney", "Brisbane" => "Australia/Brisbane", "Hobart" => "Australia/Hobart", "Vladivostok" => "Asia/Vladivostok", "Guam" => "Pacific/Guam", "Port Moresby" => "Pacific/Port_Moresby", "Magadan" => "Asia/Magadan", "Solomon Is." => "Pacific/Guadalcanal", "New Caledonia" => "Pacific/Noumea", "Fiji" => "Pacific/Fiji", "Kamchatka" => "Asia/Kamchatka", "Marshall Is." => "Pacific/Majuro", "Auckland" => "Pacific/Auckland", "Wellington" => "Pacific/Auckland", "Nuku'alofa" => "Pacific/Tongatapu", "Tokelau Is." => "Pacific/Fakaofo", "Chatham Is." => "Pacific/Chatham", "Samoa" => "Pacific/Apia"}
      end

    end
  end
end