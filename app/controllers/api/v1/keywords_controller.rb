module Api
  module V1
    class KeywordsController < ApplicationController
      # Get all Items for the current user
      def keywords_by_account
        @items = current_user.accounts.where(id: params[:acc]).first.keywords
      end

      def refresh_aggregates
        kw = Keyword.find params[:keyword_id]
        KeywordAggregateWorker.perform_async(kw.id) if kw
        render :status => 200, :json => '{"status" : "Many CPUs hard at work now..."}'
      end


      def index
        items = current_user.accounts.where(id: params[:acc]).first.organizations.where(id: params[:org]).first.keywords
        render :json => items
      end

      # TODO: validate uniqueness of many to many of keywords to organizations in @kw.organizations << @org
      # def create
      #   @org = current_user.accounts.where(id: params[:acc]).first.organizations.where(id: params[:org]).first
      #   @kw = Keyword.find_or_create_by(name: params[:keyword])
      #   @kw.organizations << @org
      #   @kw.save
      #   BingKeywords.perform_async(@kw.id)
      #   render :json => @kw.id
      # end

      def create_for_account
        @acc = current_user.accounts.where(id: params[:account_id]).first
        #name = params[:keyword]
        if params[:keyword][:tracks].nil?
          render :status => 422, :json => '{"error" : "please specify at least on value for tracks"}'
          return
        end
        if params[:keyword][:markets].nil?
          render :status => 422, :json => '{"error" : "please specify at least one market - available markets are at the markets endpoint"}'
          return
        end
        k = params[:keyword][:name]
        @kw = Keyword.find_or_create_by(name: k.downcase)
        @kw.markets = params[:keyword][:markets]
        @kw.tracks = params[:keyword][:tracks]

        if params[:keyword][:organization_id]
          @org = @acc.organizations.find(params[:keyword][:organization_id])
          @kw.organizations << @org
        end
        @kw.accounts << @acc
        @kw.save
        if @kw.tracks.include? 'facebook'
          FacebookSearchWorker.perform_async(@kw.id)
        end
        if @kw.tracks.include? 'search'
          @kw.markets.each do |m|
            BingKeywords.perform_async(@kw.id, m)
          end
        end
        if @kw.tracks.include? 'youtube'
          YoutubeSearchWorker.perform_async(@kw.id)
        end
        if @kw.tracks.include? 'instagram'
          InstagramSearchWorker.perform_async(@kw.id)
        end
        render :json => @kw
      end

      def rankings

      end

      def delete_association
        @org = current_user.accounts.where(id: params[:acc]).first.organizations.where(id: params[:org]).first
        @kw = @org.keywords.find params[:keyword_id]
        if @kw
          @org.keywords.delete(@kw)
          render :json => {message: "deleted association"}
        else
          render status: :unprocessable_entity
        end
      end
    end
  end
end
