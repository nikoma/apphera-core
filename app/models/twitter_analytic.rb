class TwitterAnalytic < ActiveRecord::Base
  belongs_to :api_partner
  belongs_to :analytics_range
  belongs_to :campaign
  #attr_accessible :api_partner_id, :campaign_id, :from, :to, :results, :analytics_range_id
end

