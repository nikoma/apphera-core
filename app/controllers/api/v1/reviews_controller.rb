module Api
  module V1
    class ReviewsController < ApplicationController
      # Get all Items for the current user
      #def index
      #  results = []
      #  items = current_user.account.organizations.map { |o| o.items }
      #  items.each do |i|
      #    unless i.empty?
      #      results << i
      #    end
      #  end
      #  @items = results
      #end


      def show
        organization = current_user.accounts.where(id: params[:account_id]).first.organizations.where(id: params[:organization_id]).first
        if params[:last]
          @reviews = organization.reviews.where("id > ?", params[:last])
        else
          @reviews = organization.reviews.where("id > ?", 0)
        end
      end
    end
  end
end
