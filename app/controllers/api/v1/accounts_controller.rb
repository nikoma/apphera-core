module Api
  module V1
    class AccountsController < ApplicationController

      # Get my own account
      def index
        @accounts = current_user.accounts
        unless @accounts
          render :status => 404, :json => {:message => "Please create an account"}
        end
        @accounts
      end

      # POST /accounts
      def create

        acct = Account.new(params[:account])
        @acct = Account.create!(:country_code_id => acct.country_code_id, :state => acct.state, :api_partner_id => current_user.id, :name => acct.name, :firstname => acct.firstname, :postalcode => acct.postalcode, :city => acct.city, :lastname => acct.lastname, :phone => acct.phone, :account_type_id => 3)
        render :json => @acct.id
      end

      # PATCH/PUT /accounts/1
      def update
        @account = current_user.accounts.find(params[:id])

        if @account.update_attributes(params[:account])
          head :no_content
        else
          render json: @account.errors, status: :unprocessable_entity
        end
      end

      # DELETE /accounts/1
      # DELETE /accounts/1.json
      def destroy
        render :status => 403, :json => {:message => "Forbidden action."}

      end
    end

  end
end
