class CreateFacebookCredentials < ActiveRecord::Migration
  def change
    create_table :facebook_credentials do |t|
      t.integer :account_id
      t.string :c_user_id
      t.string :access_token
      t.datetime :expires
      t.integer :organization_id
      t.string :facebook_id

      t.timestamps
    end
    add_index :facebook_credentials, :facebook_id
  end
end
