class FacebookCredential < ActiveRecord::Base
  belongs_to :account
  belongs_to :organization
  has_and_belongs_to_many :facebook_page_credentials, :join_table => :facebook_credentials_facebook_page_credentials
  #attr_accessible :account_id, :c_user_id, :access_token, :expires, :organization_id, :facebook_id
end
