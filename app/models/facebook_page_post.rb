class FacebookPagePost < ActiveRecord::Base
  #attr_accessible :account_id, :organization_id, :body, :post_date, :api_partner_id, :link, :name, :description, :picture, :c_user_id, :post_as_user, :page_id
  validates :api_partner_id, presence: true
  validates :body, presence: true
  validates :account_id, presence: true
end




