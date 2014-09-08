class ChangeColumnTracksToTextOnTwitterTracks < ActiveRecord::Migration
  def change
    change_column :twitter_tracks, :tracks, :text
  end
end
