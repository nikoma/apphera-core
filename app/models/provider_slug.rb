class ProviderSlug < ActiveRecord::Base
  after_create :schedule_crawler
  attr_accessible :organization_id, :slug, :bad, :content_provider_id
  belongs_to :content_provider
  belongs_to :organization
  validates_uniqueness_of :slug

  def schedule_crawler
    sch = Schedule.find_by_organization_id_and_sequence_id(self.organization_id, 3)
    Schedule.create!(name: "DailyCrawl", organization_id: self.organization_id, sequence_id: 3, in_progress: false, scheduled: Date.yesterday) unless sch
  end
end
