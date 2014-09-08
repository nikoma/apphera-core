module Api
  module V1
    class GooglePlusController < ApplicationController

      # TODO: backport part of apphera enterprise API

      def people_search
        p = params[:p]
        GooglePlusWorker.perform_async(p)
        render :json => p
      end

      def people_track

      end

      def people_untrack

      end

      def people_activities

      end

      def activity_plusones

      end

      def activity_reshares

      end

      def activity_comments

      end

    end
  end
end
# get 'google_plus/people/:id/track' => 'google_plus#people_track'
# get 'google_plus/people/:id/activities' => 'google_plus#people_activities'
# get 'google_plus/people/:id/untrack' => 'google_plus#people_untrack'
# get 'google_plus/activity/:id/plusones' => 'google_plus#activity_plusones'
# get 'google_plus/activity/:id/reshares' => 'google_plus#activity_reshares'
# get 'google_plus/activity/:id/comments' => 'google_plus#activity_comments'