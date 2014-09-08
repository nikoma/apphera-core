class TwitterAppCredential < ActiveRecord::Base
  belongs_to :api_partner
  attr_accessible :api_partner_id, :consumer_key, :consumer_secret
end
