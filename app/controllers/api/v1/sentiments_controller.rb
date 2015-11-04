# encoding: utf-8

module Api
  module V1
    class SentimentsController < ApplicationController
      def languages
        @lang = Sentiment.uniq.pluck(:language)
        render :json => @lang
      end

      def complex

        render json: DictionarySentiment.new.classify(params[:lang], params[:body])
      end

      def show
        render json: DictionarySentiment.new.classify(params[:lang], params[:body])
      end
    end
  end
end
