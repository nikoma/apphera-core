class UptimeMonitor < ActiveRecord::Base
  # For up time monitoring, part of SEO tools
  attr_accessible :load_time, :organization_id, :time_stamp, :url
  belongs_to :organization
end
