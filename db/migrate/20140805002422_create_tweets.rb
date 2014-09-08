class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets, id: false do |t|
      t.integer :id, null: false, :limit => 8
      t.integer :keyword_id
      t.integer :twitter_user_id, null: false, :limit => 8
      t.string  :twitter_user_name
      t.json :body

      t.timestamps
    end
    execute "ALTER TABLE tweets ADD PRIMARY KEY (id);"
    change_column :tweets, :created_at, :timestamp
    add_index :tweets, :keyword_id
  end
end
