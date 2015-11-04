module Api
  module V1
    class SentiController < ApplicationController
     # just forward to EE version API
      def classify
        lc = Linnaeus::Classifier.new
        input = params[:body]
        res = lc.classify input
        render :json => { :message => res }
      end

      def untrain
        lc = Linnaeus::Trainer.new
        input = params[:body]
        category = params[:category]
        lc.untrain category, input
        render :json => { :message => "Tokens removed"}
      end

      def train
        lc = Linnaeus::Trainer.new
        input = params[:body]
        category = params[:category]
        lc.train category, input
        render :json => { :message => "Training data analyzed"}
      end

      # def positive
      #   @reviews = Review.where(content_provider: 5).where(rating: 5).take(400)
      #   lt = Linnaeus::Trainer.new
      #   @reviews.each do |r|
      #     lt.train 'positive', r.body
      #   end
      #   render :json => { :message => "training positive completed"}
      # end
      # def neutral
      #   @reviews = Review.where(content_provider: 5).where(rating: 3).take(400)
      #   lt = Linnaeus::Trainer.new
      #   @reviews.each do |r|
      #     lt.train 'neutral', r.body
      #   end
      #   render :json => { :message => "neutral positive completed"}
      # end
      # def negative
      #   @reviews = Review.where(content_provider: 5).where("rating < 3").take(400)
      #   lt = Linnaeus::Trainer.new
      #   @reviews.each do |r|
      #     lt.train 'negative', r.body
      #   end
      #   render :json => { :message => "training negative completed"}
      # end
      end
    end
  end

