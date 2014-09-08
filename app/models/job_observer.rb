class JobObserver < ActiveRecord::Base
  attr_accessible :failed, :organization_id, :retry_count, :schedule_id
  validates_uniqueness_of :schedule_id
  belongs_to :schedule

end
