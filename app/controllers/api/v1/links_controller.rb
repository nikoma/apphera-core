module Api
  module V1
    class LinksController < ApplicationController

      def index
        @links = current_user.accounts.where(id: params[:acc]).first.organizations.where(id: params[:org]).first.organization_links

      end

    end
  end
end
