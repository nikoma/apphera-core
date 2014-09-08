module Api
  module V1
    class ReviewersController < ApplicationController

      def show
        @reviewer = Reviewer.find params[:id]
      end

      def reviewer_reviews
        reviewer = Reviewer.find params[:id]
        @reviews = reviewer.reviews
      end

    end
  end
end
