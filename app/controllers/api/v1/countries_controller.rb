module Api
  module V1
    class CountriesController < ApplicationController
      def index
        @countries = CountryCodes.all
      end

      #def show
      #  @categories = Category.where(country_id: params[:id])
      #end
    end
  end
end
