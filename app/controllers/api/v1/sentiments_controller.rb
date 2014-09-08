module Api
  module V1
    class SentimentsController < ApplicationController
      def languages
        @lang = Sentiment.uniq.pluck(:language)
        render :json => @lang
      end

      def complex
        @lang = params[:lang]
        @sentence = params[:body].split(/\W+/)

        res = 0.0
        score = 0.0

        @sentence.each do |i|
          res = $redis.get("#{@lang}"+":"+"#{i}").to_f
          if !res.nil?
            score += res
          end
        end
        senti = score.to_d
        value = 0
        if senti >= 0.03
          value = 1
        elsif senti <= -0.01
          value = -1
        end
        @sentiment = {polarity: value, sentiment: senti}
        render json: @sentiment
      end

      def show
        @lang = params[:lang]
        @sentence = params[:body].split(/\W+/)

        res = 0.0
        score = 0.0

        @sentence.each do |i|
          res = $redis.get("#{@lang}"+":"+"#{i}").to_f
          if !res.nil?
            score += res
          end
        end
        senti = score.to_d
        value = 0
        if senti >= 0.03
          value = 1
        elsif senti <= -0.01
          value = -1
        end
        @sentiment = {polarity: value, sentiment: senti}
        render json: @sentiment
      end
    end
  end
end
