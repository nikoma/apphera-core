class AddCUserIdToFacebookPageCredentials < ActiveRecord::Migration
  def change
    add_column :facebook_page_credentials, :c_user_id, :string
    add_index :facebook_page_credentials, :c_user_id
  end
end
