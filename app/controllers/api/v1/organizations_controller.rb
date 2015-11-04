module Api
  module V1
    class OrganizationsController < ApplicationController
      # GET /organizations
      # GET /organizations.json
      def index
        begin
          @organizations = @current_user.accounts.where(id: params[:account_id]).first.organizations

        rescue
          render :status => 404
          return
        end
        unless @organizations
          render :status => 404, :json => {:message => "Please create a organization"}
          return
        end
        @organizations
      end

      def show
        @organization = @current_user.accounts.where(id: params[:account_id]).first.organizations.where(id: params[:organization_id]).first
      end

      # GET /organizations/1?token=....
      # def show
      #   account = current_user.account
      #   @organization = Organization.find(params[:id])
      #   unless @organization.account_id == account.id
      #     render :status=>403, :json=>{:message=>"Invalid Organization ID."}
      #   end
      #
      # end
      # def stuff
      #   render :json=> params[:id]
      # end

      # GET /organizations/new
      # GET /organizations/new.json


      # POST /organizations
      # POST /organizations.json
      def create
        @organization = Organization.new(params[:organization])
        acc = current_user.accounts.where(id: params[:account_id]).first
        name = @organization.name
        existing = @organization.existing?(@organization)
        if existing
          @organization = Organization.find existing
          @organization.account_id = acc.id
          @organization.save!
          FoursquareWorker.perform_async(@organization.id)
          return @organization #test
        else
          @organization.account_id = acc.id
          @organization.yahooslug = SecureRandom.urlsafe_base64
          @organization.save!
          FoursquareWorker.perform_async(@organization.id)
          unless Rails.env.test? or Rails.env.development?
            BingApi.perform_async(@organization.id)
            CompSearch.perform_async(@organization.id)
          end
          return @organization
        end
        render json: @organization.errors, status: :unprocessable_entity
      end


      # PATCH/PUT /organizations/1
      # PATCH/PUT /organizations/1.json

      def update
        @organization = @current_user.accounts.where(id: params[:account_id]).first.organizations.where(id: params[:organization_id]).first

        if @organization.update_attributes(params[:organization])
          head :no_content
        else
          render json: @organization.errors, status: :unprocessable_entity
        end
      end

      # DELETE /organizations/1
      # DELETE /organizations/1.json
      def destroy
        render :status => 403, :json => {:message => "Forbidden action."}

      end
    end
  end
end
