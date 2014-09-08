class CreateYoutubeVideos < ActiveRecord::Migration
  def change
    create_table :youtube_videos do |t|
      t.integer :keyword_id
      t.integer :duration
      t.boolean :widescreen
      t.boolean :noembed
      t.integer :position
      t.boolean :safe_search
      t.string :video_id
      t.datetime :published_at
      t.datetime :updated_at
      t.datetime :uploaded_at
      t.datetime :recorded_at
      t.json :categories
      t.json :keywords
      t.string :description
      t.string :title
      t.string :html_content
      t.json :thumbnails
      t.string :player_url
      t.integer :view_count
      t.integer :favorite_count

      t.timestamps
    end
    add_index :youtube_videos, :keyword_id
    add_index :youtube_videos, :video_id
  end
end
