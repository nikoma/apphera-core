class FacebookPagePostWorker
  include Sidekiq::Worker
#TODO: think if this is trustworthy as its generated only by the controller.
  def perform(id)
    access_token = ''
    post = FacebookPagePost.find(id)
    if post.post_as_user
      access_token = FacebookCredential.where(c_user_id: post.c_user_id).first.access_token
    else
      access_token = FacebookPageCredential.where(fb_id: post.page_id).first.access_token
    end
    begin
      page = FbGraph::Page.new(post.page_id, :access_token => access_token).fetch
    rescue
      p "fb graph error"
    end
    if post.link or post.picture
      page.feed!(
          :message => post.body,
          :picture => post.picture,
          :link => post.link,
          :name => post.name,
          :description => post.description
      )
    else
      page.feed!(
          :message => post.body,
      )
    end
  end
end