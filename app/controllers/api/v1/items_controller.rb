module Api
  module V1
    class ItemsController < ApplicationController
      # Get all Items for the current user
      def index
        results = []
        items = current_user.accounts.where(id: params[:account_id]).first.organizations.map { |o| o.items }
        items.each do |i|
          unless i.empty?
            results << i
          end
        end
        @items = results
      end

      def account_items
        @item = current_user.accounts.where(id: params[:account_id]).first.items
      end

      # Get a single Item - TODO: add the scope that the user can only see items belonging to his own organizations
      def show
        @item = Item.find(params[:id])
      end
    end
  end
end

