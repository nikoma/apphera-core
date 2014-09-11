class FacebookCredentialsWorker
  include Sidekiq::Worker

  def perform(account_id, user_access_token, c_user_id)
    @account = Account.find account_id
    @user_graph = Koala::Facebook::API.new(user_access_token)
    pages = @user_graph.get_connections('me', 'accounts')
    begin
      pages.each do |p|
        name = p['name']
        category = p['category']
        access_token = p['access_token']
        perms = p['perms'].to_json
        fb_id = p['id']
        @fb = FacebookPageCredential.find_or_initialize_by(fb_id: fb_id)
        @fb.update(name: name)
        @fb.update(c_user_id: c_user_id)
        @fb.update(category: category)
        @fb.update(account_id: @account.id)
        @fb.update(perms: perms)
        @fb.update(access_token: access_token)
        @fb.save
      end
    rescue => e
      puts e.inspect
    end

  end
end
