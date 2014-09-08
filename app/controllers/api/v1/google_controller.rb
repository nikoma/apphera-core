module Api
  module V1
    class GoogleController < ApplicationController
      # TODO: backport part of apphera enterprise API

      def index
        render :json => SomeClass.all
      end


    end
  end
end
