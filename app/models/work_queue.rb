class WorkQueue < ActiveRecord::Base
  attr_accessible :content_provider, :keywords, :misc, :org_id, :queue_name, :retry_count, :schedule_id, :url
end
