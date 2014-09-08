module Api
  module V1
    class DashController < ApplicationController
      skip_before_filter :authenticate_user

      def index

      end

    end
  end
end

