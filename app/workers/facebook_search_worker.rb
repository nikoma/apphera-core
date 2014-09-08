class FacebookSearchWorker
  include Sidekiq::Worker

  def perform(id)
    kw = Keyword.find(id)
    token = ENV["FB_KEY"]

    res = FbGraph::Searchable.search(kw.name, :access_token => token) # => Array of Hash

    res.each do |r|
      FacebookItem.create!(keyword_id: id, body: r.to_json)
    end
    # begin
    #   @graph = Koala::Facebook::API.new(token)
    #   profile = @graph.get_object("me")
    #   @graph.put_connections("me", "feed", :message => body)
    # rescue Exception => e
    #   puts e.message
    # end
  end
end