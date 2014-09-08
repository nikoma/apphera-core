class AddFulltextIndexToTweets < ActiveRecord::Migration
  def change
    execute <<-SQL
      CREATE INDEX tweets_body_search_idx
      ON tweets
      USING gin(to_tsvector('english', body->>'text'));
    SQL
  end
end
