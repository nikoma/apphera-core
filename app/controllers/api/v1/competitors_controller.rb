module Api
  module V1
    class CompetitorsController < ApplicationController
      # Get all Items for the current user


      def show
        organization = current_user.accounts.find(params[:acc]).organizations.find params[:id]
        if organization
          @competitors = organization.organizations
        end
      end
    end
  end
end
