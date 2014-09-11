class FacebookCredential < ActiveRecord::Base
  belongs_to :account
  belongs_to :organization
  belongs_to :facebook_page_credential
  attr_accessible :account_id, :c_user_id, :access_token, :expires, :organization_id, :facebook_id
end
