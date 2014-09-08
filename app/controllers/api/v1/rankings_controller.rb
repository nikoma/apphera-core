module Api
  module V1
    class RankingsController < ApplicationController

      def index
        render :json => Keyword.find(params[:id]).rankings.first
      end

    end
  end
end
