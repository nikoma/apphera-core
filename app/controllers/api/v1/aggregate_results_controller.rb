module Api
  module V1
    class AggregateResultsController < ApplicationController

      ## GET /aggregate_results
      #def index
      #  @aggregate_results = AggregateResult.all
      #
      #  render json: @agregate_results
      #end

      # GET /aggregate_results/1
      def show
        aggregate_results = current_user.accounts.where(id: params[:acc]).first.organizations.where(id: params[:orgid]).first.aggregate_results.last
        render :json => aggregate_results
      end

      # GET /aggregate_results/new
      # GET /aggregate_results/new.json

    end
  end
end

