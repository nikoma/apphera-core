class TwitterAppCredential < ActiveRecord::Base
  belongs_to :api_partner
  attr_accessible :api_partner_id, :consumer_key, :consumer_secret
  validates_length_of :consumer_key, :minimum => 5
  validates_length_of :consumer_secret, :minimum => 5
  validates_uniqueness_of :api_partner_id
end
