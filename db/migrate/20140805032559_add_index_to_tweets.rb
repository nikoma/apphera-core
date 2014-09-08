class AddIndexToTweets < ActiveRecord::Migration
  def change
    add_index :tweets, :twitter_user_id
  end
end
