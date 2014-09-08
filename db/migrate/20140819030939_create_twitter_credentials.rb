class CreateTwitterCredentials < ActiveRecord::Migration
  def change
    create_table :twitter_credentials do |t|
      t.integer :account_id
      t.string :c_user_id
      t.string :oauth_token
      t.string :oauth_secret
      t.datetime :expires
      t.string :organization_id
      t.string :twitter_id

      t.timestamps
    end
    add_index :twitter_credentials, :account_id
  end
end
