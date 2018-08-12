class FacebookPost < ActiveRecord::Base
  belongs_to :organization
  belongs_to :account
  belongs_to :api_partner
  #attr_accessible :account_id, :organization_id, :body, :post_date, :token, :api_partner_id, :link, :name, :description, :picture
  validates :api_partner_id, presence: true
  validates :body, presence: true
end
