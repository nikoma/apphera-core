module Api
  module V1
    class TracksController < ApplicationController

      # paginate Bla.count, max_per_page do |limit, offset|
      #   render json: Bla.limit(limit).offset(offset)
      # end

      def index
        @tracks = Track.all
      end

      def facebook
        max_per_page = 100
        paginate Keyword.find(params[:keyword_id]).facebook_items.count, max_per_page do |limit, offset|
          @facebook_items = Keyword.find(params[:keyword_id]).facebook_items.limit(limit).offset(offset)
        end
      end

      def youtube
        max_per_page = 100
        paginate YoutubeVideo.where(keyword_id: params[:keyword_id]).count, max_per_page do |limit, offset|
          render :json => YoutubeVideo.where(keyword_id: params[:keyword_id]).limit(limit).offset(offset).all_json
        end
      end

      def twitter
        max_per_page = 100
        kw = Keyword.find(params[:keyword_id])
        @kw = kw.name.gsub(' ', ' & ')
        paginate Tweet.where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', '#{@kw}')").count, max_per_page do |limit, offset|
          render :json => Tweet.where("to_tsvector('simple', body->>'text') @@ to_tsquery('simple', '#{@kw}')").limit(limit).offset(offset).all_json
        end
      end

      def instagram
        max_per_page = 100
        paginate InstagramItem.where(keyword_id: params[:keyword_id]).count, max_per_page do |limit, offset|
          render :json => InstagramItem.where(keyword_id: params[:keyword_id]).all_json
        end
      end

      def search
        market = Market.where(name: params[:market]).first
        render :json => Keyword.find(params[:keyword_id]).rankings.where(market: market).first
      end
    end
  end
end
