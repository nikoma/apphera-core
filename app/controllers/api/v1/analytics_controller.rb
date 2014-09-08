module Api
  module V1
    class AnalyticsController < ApplicationController

      def index

       render :json => @current_user.accounts.where(id: params[:account_id]).first.named_queries

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
    end
  end
end