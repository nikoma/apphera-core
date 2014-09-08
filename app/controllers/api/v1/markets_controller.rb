module Api
  module V1
    class MarketsController < ApplicationController

      def index
        @markets = Market.all
      end

    end
  end
end
