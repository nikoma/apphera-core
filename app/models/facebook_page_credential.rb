class FacebookPageCredential < ActiveRecord::Base
  belongs_to :account
  belongs_to :organization
  has_and_belongs_to_many :facebook_page_credentials
  attr_accessible :account_id, :name, :category, :access_token, :perms, :organization_id, :fb_id,:has_token
  validates_presence_of :account_id, :access_token, :name, :perms
end
