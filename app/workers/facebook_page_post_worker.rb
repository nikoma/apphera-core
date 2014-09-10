class FacebookPagePostWorker
  include Sidekiq::Worker

  def perform(id)
    access_token = ''
    post = FacebookPagePost.find(id)
    if post.post_as_user
      access_token = FacebookCredential.where(c_user_id: post.c_user_id).first.access_token
    else
      access_token = FacebookPageCredential.where(page_id: post.page_id).first.access_token
    end

    me = FbGraph::Page.new(post.page_id, :access_token => access_token).fetch
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
  end
end