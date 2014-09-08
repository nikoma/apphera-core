class CreateTwitterAppCredentials < ActiveRecord::Migration
  def change
    create_table :twitter_app_credentials do |t|
      t.integer :api_partner_id
      t.string :consumer_key
      t.string :consumer_secret

      t.timestamps
    end
    add_index :twitter_app_credentials, :api_partner_id
  end
end
