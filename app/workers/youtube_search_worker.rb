class YoutubeSearchWorker
  include Sidekiq::Worker
  require 'youtube_it'

  def perform(id)


    token = ENV["YOUTUBE_TOKEN"]
    @kw = Keyword.find id
    client = YouTubeIt::Client.new(:dev_key => token)
    v = client.videos_by(:query => @kw.name)
    v.videos.each do |vi|
      begin
        YoutubeVideo.create!(keyword_id: @kw.id, duration: vi.duration, widescreen: vi.widescreen, noembed: vi.noembed, position: vi.position,
                             safe_search: vi.safe_search, video_id: vi.video_id, published_at: vi.published_at, updated_at: vi.updated_at, uploaded_at: vi.uploaded_at,
                             recorded_at: vi.recorded_at, categories: vi.categories, keywords: vi.keywords, description: vi.description, title: vi.title, html_content: vi.html_content,
                             thumbnails: vi.thumbnails, player_url: vi.player_url, view_count: vi.view_count, favorite_count: vi.favorite_count)
      rescue => e
        puts e.inspect
      end
    end

  end
end


