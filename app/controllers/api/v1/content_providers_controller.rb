module Api
  module V1
    class ContentProvidersController < ApplicationController
      def index
        @content_providers = ContentProvider.all
      end


    end
  end
end

