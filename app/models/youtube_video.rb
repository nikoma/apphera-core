class YoutubeVideo < ActiveRecord::Base
  belongs_to :keyword
  #attr_accessible :keyword_id, :duration, :widescreen, :noembed, :position, :safe_search, :video_id, :published_at, :updated_at, :uploaded_at, :recorded_at,
               #   :categories, :keywords, :description, :title, :html_content, :thumbnails, :player_url, :view_count, :favorite_count
end


