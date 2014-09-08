# class FacebookPagesWorker
#   include Sidekiq::Worker
#
#   def perform(id, page_id)
#     post = FacebookPost.find(id)
#     @graph = Koala::Facebook::API.new(post.token)
#     begin
#       @graph.put_object(page_id, "feed", :message => post.body)
#     rescue => e
#       puts e.inspect
#     end
#
#   end
# end
#
