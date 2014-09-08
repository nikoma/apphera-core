module Api
  module V1
    class CategoriesController < ApplicationController
      # Get all Items for the current user
      def index
        @categories = Category.all.sort_by &:name
      end

      # Takes company ID as argument
      def show
        @categories = Category.where(country_id: params[:id]).sort_by &:name
      end
    end
  end
end
