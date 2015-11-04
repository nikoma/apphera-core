module Api
  module V1

    class TwitterController < ApplicationController

      $nodeapi = ENV["APPHERA_TWITTER_API"];

      def followers_count
        render :json => HTTParty.get($nodeapi +"/tweets/followers_count", :headers => {"apikey" => "abcdefghij"}).body;
      end

      def followers_average
        render :json => HTTParty.get($nodeapi +"/tweets/followers_average", :headers => {"apikey" => "abcdefghij"}).body;
      end

      def user_followers_ranking
        render :json => HTTParty.get($nodeapi +"user_followers_ranking", :headers => {"apikey" => "abcdefghij"}).body;
      end

      def user_tweets
        max_per_page = 100
        paginate Tweet.where(twitter_user_id: params[:user_id]).where('id > ?', 1).count, max_per_page do |limit, offset|
          render :json => Tweet.where(twitter_user_id: params[:user_id]).limit(limit).offset(offset).all_json
        end
      end

      def tweet_search
        start = params[:start] || 1000.days.ago
        end_date = params[:end] || Date.tomorrow
        max_per_page = 100
        kw = params[:search]
        k = kw.gsub(' ', ' & ')
        paginate Tweet.where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', '#{k}')").where('created_at > ? and created_at < ?', start, end_date).count, max_per_page do |limit, offset|
          render :json => Tweet.where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', '#{k}')").where('created_at > ? and created_at < ?', start, end_date).limit(limit).offset(offset).all_json
        end
      end

      def tweet
        @twitter_app = current_user.twitter_app_credential
        tweet = params[:tweet][:body]
        twitter_user = TwitterCredential.where(c_user_id: params[:tweet][:c_user_id]).first
        if twitter_user.nil?
          render :status => 422, :json => {message: 'Could not find user credentials.'}
          return
        end
        client = Twitter::REST::Client.new do |config|
          config.consumer_key = @twitter_app.consumer_key
          config.consumer_secret = @twitter_app.consumer_secret
          config.access_token = twitter_user.oauth_token
          config.access_token_secret = twitter_user.oauth_secret
        end
        if params[:tweet][:in_reply_to]
          begin
            render :json => client.update(tweet, :in_reply_to_status_id => params[:tweet][:in_reply_to] )
            return
          rescue => e
            render :json => e.inspect.to_json
          end
        end
        if params[:tweet][:retweet_id]
          begin
            render :json => client.retweet(params[:tweet][:retweet_id] )
            return
          rescue => e
            render :json => e.inspect.to_json
          end
        end


        begin
          render :json => client.update(tweet)
        rescue => e
          render :json => e.inspect.to_json

        end
      end

      def read_timeline
        @twitter_app = current_user.twitter_app_credential
        twitter_user = TwitterCredential.where(c_user_id: params[:c_user_id]).first
        if twitter_user.nil?
          render :status => 422, :json => {message: 'Could not find user credentials.'}
          return
        end
        client = Twitter::REST::Client.new do |config|
          config.consumer_key = @twitter_app.consumer_key
          config.consumer_secret = @twitter_app.consumer_secret
          config.access_token = twitter_user.oauth_token
          config.access_token_secret = twitter_user.oauth_secret
        end
        begin
          render :json => client.home_timeline.to_json
        rescue => e
          render :json => e.inspect.to_json

        end

      end


      def set_app_credentials
        @api_partner = current_user
        @credential = TwitterAppCredential.new(params[:twitter_app_credential])
        @credential.api_partner_id= current_user.id
        render :json => @credential.save
      end

      def get_app_credentials
        render :json => @current_user.twitter_app_credential

      end

      def delete_app_credentials
        @credential = @current_user.twitter_app_credential
        render :json => @credential.delete

      end

      def update_app_credentials
        @credential = @current_user.twitter_app_credential
        @credential.update_attributes(params[:twitter_app_credential])
        render :json => @credential.save
      end


      def set_credentials
        # organization_id = params[:organization_id] || nil
        @account = current_user.accounts.where(id: params[:twitter_credential][:account_id]).first
        @credential = TwitterCredential.new(params[:twitter_credential])
        @credential.account_id= @account.id
        @credential.save
        render :json => {:message => 'stored twitter credentials credentials for account: ' + @account.id.to_s}
      end

      def get_credentials
        account_id = params[:account_id]
        @account = current_user.accounts.where(id: account_id).first
        render :json => @account.twitter_credentials
      end

      def delete_credentials
        @account = current_user.accounts.where(id: params[:account_id]).first
        begin
          @credentials = @account.twitter_credentials.where(c_user_id: params[:id]).first
          @credentials.destroy
        rescue
          render :status => 404, :json => {:message => 'record not found'}
          return
        end
        render :json => {:message => 'Record deleted'}
      end

      def users_count
        render :json => HTTParty.get($nodeapi +"/tweets/users/count", :headers => {"apikey" => "abcdefghij"}).body;
      end

      def newest
        render :json => HTTParty.get($nodeapi +"/tweets/newest", :headers => {"apikey" => "abcdefghij"}).body;
      end
      # def followers_count
      #   render :json => HTTParty.get($nodeapi +"/tweets/followers_count", :headers => {"apikey" => "abcdefghij"}).body;
      # end
    end
  end
end

