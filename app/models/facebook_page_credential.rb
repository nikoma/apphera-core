class FacebookPageCredential < ActiveRecord::Base
  belongs_to :account
  belongs_to :organization
  has_and_belongs_to_many :facebook_credentials, :join_table => :facebook_credentials_facebook_page_credentials
  attr_accessible :account_id, :name, :category, :access_token, :perms, :organization_id, :fb_id,:has_token, :c_user_id
  validates_presence_of :account_id, :access_token, :name, :perms
end
