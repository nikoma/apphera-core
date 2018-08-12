class AnalyticsResult < ActiveRecord::Base
  #attr_accessible :campaign_id, :account_id, :date_range_id, :results
  belongs_to :campaign
  belongs_to :date_range
  belongs_to :account
end
