class Schedule < ActiveRecord::Base
  after_save :reschedule_crawler
  #attr_accessible :name, :organization_id, :sequence_id, :in_progress, :scheduled, :description, :created_at, :updated_at, :payload
  belongs_to :organization
  belongs_to :sequence
  has_one :job_observer
  validates_presence_of :organization_id

  def reschedule_crawler
    if self.in_progress == true and self.sequence_id == 3
      self.scheduled = Date.tomorrow
      self.in_progress = false
      self.save
      job = JobObserver.where(schedule_id: self.id).first
      unless job
        JobObserver.create!(organization_id: self.organization_id, schedule_id: self.id, retry_count: 0, failed: false)
      end
    end
    if self.in_progress == true and self.sequence_id == 2
      job = JobObserver.where(schedule_id: self.id).first
      unless job
        JobObserver.create!(organization_id: self.organization_id, schedule_id: self.id, retry_count: 0, failed: false)
      end
    end
  end

end
