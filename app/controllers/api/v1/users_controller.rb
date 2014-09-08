module Api
  module V1
    class UsersController < ApplicationController
      skip_before_filter :authenticate_user, :only => [:index]

      # User signup needs a token too. We have one "generic" token we use for our mobile apps. A user with no data attached
      #
      # GET /users/1.json
      def index
        unless params[:email] && params[:password]
          render :status => 403, :json => {:message => "email & password missing"}
          return
        end
        @user = User.find_by_email(params[:email])

        if @user && @user.valid_password?(params[:password])
          @user
        else
          render :status => 403, :json => {:message => @user.errors}
        end
      end

      # GET /users/new
      # GET /users/new.json
      def new
        @user = User.new

        render json: @user
      end

      # POST /users
      def create
        name = params[:name]
        email = params[:email]
        password = params[:password]
        reseller_id = 1
        is_reseller = false

        @user = User.create(name: name, email: email, reseller_id: reseller_id, password: password)

        if @user.save
        else
          render :status => 403, :json => {:message => @user.errors.full_messages}
        end
      end

      # PATCH/PUT /users/1
      # PATCH/PUT /users/1.json
      def update
        @user = User.find(params[:id])
        if @user.update_attributes(params[:user])
          head :no_content
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      # DELETE /users/1
      # DELETE /users/1.json
      def destroy
        @user = User.find(params[:id])
        render :status => 403, :json => {:message => "Forbidden action."}
      end

    end
  end
end
