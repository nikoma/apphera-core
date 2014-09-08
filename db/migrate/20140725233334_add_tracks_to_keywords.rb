class AddTracksToKeywords < ActiveRecord::Migration
  def change
    add_column :keywords, :tracks, :string, :array => true
  end
end
