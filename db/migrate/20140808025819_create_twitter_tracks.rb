class CreateTwitterTracks < ActiveRecord::Migration
  def change
    create_table :twitter_tracks do |t|
      t.integer :account_id
      t.string :tracks

      t.timestamps
    end
    add_index :twitter_tracks, :account_id
  end
end
