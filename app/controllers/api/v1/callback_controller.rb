module Api
  module V1
    class CallbackController < ApplicationController

      # TODO: backport part of apphera enterprise API
      def test
        @api_partner = @current_user

      end


    end
  end
end
