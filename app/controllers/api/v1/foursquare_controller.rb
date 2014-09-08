module Api
  module V1
    class FoursquareController < ApplicationController

      def index
        foursquare_venues = current_user.accounts.where(id: params[:acc]).first.organizations.where(id: params[:org]).first.foursquare_venues

        render :json => foursquare_venues
      end


    end
  end
end
