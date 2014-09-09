class FacebookCredential < ActiveRecord::Base
  belongs_to :account
  belongs_to :organization
  attr_accessible :account_id, :c_user_id, :oauth_token, :oauth_secret, :expires, :organization_id, :facebook_id
end
