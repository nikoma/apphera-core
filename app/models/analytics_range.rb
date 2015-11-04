class AnalyticsRange < ActiveRecord::Base
  include ActiveModel::Validations
  belongs_to :api_partner
  has_many :twitter_analytics, :dependent => :destroy
  attr_accessible :api_partner_id, :name, :from, :to
  validates_presence_of :from, :to, :name, :api_partner_id
  validates_with DateParserValidator

end


