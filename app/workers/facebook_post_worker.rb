class FacebookPostWorker
  include Sidekiq::Worker

  def perform(id)
    post = FacebookPost.find(id)
    me = FbGraph::User.me(post.token)
    if post.link or post.picture
      me.feed!(
          :message => post.body,
          :picture => post.picture,
          :link => post.link,
          :name => post.name,
          :description => post.description
      )
    else
      me.feed!(
          :message => post.body,
      )
    end

    # Older alternative way
    # begin
    #   @graph = Koala::Facebook::API.new(token)
    #   profile = @graph.get_object("me")
    #   @graph.put_connections("me", "feed", :message => body)
    # rescue Exception => e
    #   puts e.message
    # end
  end
end