class InstagramSearchWorker
  include Sidekiq::Worker


  def perform(id)
    @key = Keyword.find id
    token = ENV["INSTAGRAM_KEY"]
    client = Instagram.client(:access_token => token)
    tag_guess = @key.name.gsub!(' ', '_')
    tags = client.tag_search(tag_guess)
    media = client.tag_recent_media(tags.first.name)

    media.each do |m|
      InstagramItem.create!(keyword_id: @key.id, body: m)
    end


  end


end