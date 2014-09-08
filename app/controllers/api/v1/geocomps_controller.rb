module Api
  module V1
    class GeocompsController < ApplicationController
      # Get all Items for the current user
      def index
        radius = params[:r].to_f || 1.0
        radius = 50 if radius > 50
        lat = params[:lat].to_f
        lon = params[:lon].to_f
        cat = params[:cat].to_i
        @competitors = Organization.where(category_id: cat).near([lat, lon], radius, :order => "distance").limit(40)
      end
    end
  end
end
