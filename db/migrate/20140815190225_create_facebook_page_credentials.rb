class CreateFacebookPageCredentials < ActiveRecord::Migration
  def change
    create_table :facebook_page_credentials do |t|
      t.integer :account_id
      t.json :perms
      t.integer :organization_id
      t.string :fb_id
      t.string :name
      t.string :category
      t.boolean :has_token

      t.timestamps
    end
    add_index :facebook_page_credentials, :account_id
    add_index :facebook_page_credentials, :organization_id
    add_index :facebook_page_credentials, :fb_id
    add_index :facebook_page_credentials, :name
    add_index :facebook_page_credentials, :category
  end
end
