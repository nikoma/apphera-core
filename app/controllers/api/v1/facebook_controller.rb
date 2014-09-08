module Api
  module V1
    class FacebookController < ApplicationController
      # TODO: backport part of apphera enterprise API

      def facebook_post
        fp = FacebookPost.create!(params[:facebook_post].merge(:api_partner_id => current_user.id))
        if fp.post_date != nil and fp.post_date > DateTime.now
          render :json => {:message => 'Scheduled for: ' + fp.post_date.to_s}
        else
        FacebookPostWorker.perform_async(fp.id)
        render :json => {:message => 'queued massage: ' + fp.to_json}
        end
      end

      # TODO: persist? yes/no?
      def read_wall
        @account = current_user.accounts.where(id: params[:account_id]).first
        page_token = FacebookPageCredential.where(fb_id: params[:fb_id]).first.access_token
        @page_graph = Koala::Facebook::API.new(page_token)
        render :json => @page_graph.get_connection('me', 'feed')
      end

      def set_page_credentials
        user_access_token = params[:user_access_token]
        account_id = params[:account_id]
       # organization_id = params[:organization_id] || nil
        @account = current_user.accounts.where(id: account_id).first
        FacebookCredentialsWorker.perform_async(@account.id, user_access_token)
        render :json => {:message => 'requesting facebook credentials for account: ' + @account.id.to_s}
      end
      def get_page_credentials
        account_id = params[:account_id]
        @account = current_user.accounts.where(id: account_id).first
        render :json => @account.facebook_page_credentials
      end

      def delete_page_credentials
        @account = current_user.accounts.where(id: params[:account_id]).first
        begin
          @credentials = @account.facebook_page_credentials.where(fb_id: params[:fb_id]).first
          @credentials.destroy
        rescue
          render :status => 404, :json => {:message => 'record not found'}
          return
        end
        render :json => {:message => 'Record deleted'}
      end

      def set_credentials
        # organization_id = params[:organization_id] || nil
        @account = current_user.accounts.where(id: params[:twitter_credential][:account_id]).first
        @credential = TwitterCredential.new(params[:twitter_credential])
        @credential.account_id= @account.id
        @credential.save
        render :json => {:message => 'stored twitter credentials credentials for account: ' + @account.id.to_s}
      end

      def get_credentials
        account_id = params[:account_id]
        @account = current_user.accounts.where(id: account_id).first
        render :json => @account.twitter_credentials
      end

      def delete_credentials
        @account = current_user.accounts.where(id: params[:account_id]).first
        begin
          @credentials = @account.twitter_credentials.where(c_user_id: params[:id]).first
          @credentials.destroy
        rescue
          render :status => 404, :json => {:message => 'record not found'}
          return
        end
        render :json => {:message => 'Record deleted'}
      end

      # TODO: Move into worker with callback
      def pages_settings
        account_id = params[:account_id]
        # user_access_token = params[:user_access_token]
        @account = current_user.accounts.where(id: account_id).first
        requested_page = params[:fb_id]
        @credential = @account.facebook_page_credentials.where(fb_id: requested_page).first
        if @credential.nil?
          render :status => 422, :json => {:message => 'You need to request a valid access token by calling the page credentials endpoint'} and return
        end

        query = params[:query]

        page = FbGraph::Page.new(requested_page).fetch(
            :access_token => @credential.access_token,
            :fields => :access_token
        )
        case query
          when 'enabled-settings'
            render :json => page.settings.to_json
          when 'users-can-post'
            render :json => page.users_can_post?.to_json
          when 'users-can-post-photos'
            render :json => page.users_can_post_photos?.to_json
          when 'users-can-tag-photos'
            render :json => page.users_can_tag_photos?.to_json
          when 'users-can-post-videos'
            render :json => page.users_can_post_videos?.to_json
          when 'allow-posting'
            render :json => page.users_can_post!.to_json
          when 'allow-posting-photos'
            render :json => page.users_can_post_photos!.to_json
          when 'allow-tagging-photos'
            render :json => page.users_can_tag_photos!.to_json
          when 'allow-posting-videos'
            render :json => page.users_can_post_videos!.to_json
          when 'deny-posting'
            render :json => page.users_cannot_post!.to_json
          when 'deny-posting-photos'
            render :json => page.users_cannot_post_photos!.to_json
          when 'deny-tagging-photos'
            render :json => page.users_cannoy_tag_photos!.to_json
          when 'deny-posting-videos'
            render :json => page.users_cannot_post_videos!.to_json
          else
            render :json => {:message => 'unknown method, please refer to http://www.apphera.com/Home/Documentation'}
        end


        def unknown
          render :json => {:message => 'unknown method'}
        end


    end
  end
  end
end