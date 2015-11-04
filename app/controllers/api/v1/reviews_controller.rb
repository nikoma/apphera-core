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
      def crawl
        org = current_user.accounts.where(id: params[:account_id]).first.organizations.where(id: params[:organization_id]).first
        if org.nil?
          render :status => 422, :json => { :message => "Could not find Organization"}
          return
        end
        slug = org.provider_slugs.where(content_provider_id: 27).first # that is zomato
        if slug.nil?
          render :status => 422, :json => { :message => "Could not find a slug for Organization"}
          return
        end
        ZomatoWorker.perform_async(slug.slug, org.id, 27)
        render :status => 200, :json => { :message => "Crawler working"}

      end

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
