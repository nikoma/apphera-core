class AddAccessTokenToFacebookPageCredentials < ActiveRecord::Migration
  def change
    add_column :facebook_page_credentials, :access_token, :string
  end
end
