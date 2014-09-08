module Api
  module V1
    class Queue < ApplicationController
      # TODO: backport part of apphera enterprise API

      def index
        render :json => SomeClass.all
      end

    end
  end
end
