module Api
  module V1
    class CampaignsController < ApplicationController
      # Get all campaigns
      def index
        @campaigns = @current_user.accounts.where(id: params[:account_id]).first.campaigns
      end



      def create
        @account = @current_user.accounts.where(id: params[:account_id]).first
        @campaign = Campaign.create(params[:campaign])
        @campaign.account_id = @account.id
        render :json => @campaign.save
      end

      def edit
        @account = @current_user.accounts.where(id: params[:account_id]).first
        @campaign = @account.campaigns.find params[:campaign_id]
        @campaign.update_attributes params[:campaign]
        @campaign.account_id = @account.id
        render :json => @campaign.save
      end

      def add_keywords
        @account = @current_user.accounts.where(id: params[:account_id]).first
        @campaign = @account.campaigns.find params[:campaign_id]
        keywords = params[:keywords]
        keywords.each do |k|
          kw = Keyword.find k
          @campaign.keywords << kw
          @campaign.save
        end
        render :json => @campaign
      end

      def update_keywords
        @account = @current_user.accounts.where(id: params[:account_id]).first
        @campaign = @account.campaigns.find params[:campaign_id]
        keywords = params[:keywords]
        @campaign.keywords.delete_all
        keywords.each do |k|
          kw = Keyword.find k
          @campaign.keywords << kw
          @campaign.save
        end
        render :json => @campaign
      end


      def destroy
        @account = @current_user.accounts.find params[:account_id]
        @campaign = @account.campaigns.find params[:campaign_id]
        render :json => @campaign.delete
      end

    end

  end
end

