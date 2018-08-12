class Keyword < ActiveRecord::Base
  after_create :create_schedule
  has_and_belongs_to_many :organizations
  has_and_belongs_to_many :accounts
  has_and_belongs_to_many :campaigns, uniq: true
  has_many :rankings
  has_many :facebook_items
  has_many :instagram_items
  has_many :youtube_videos
  has_many :news_items
  has_many :keyword_aggregates
  #attr_accessible :name, :tracks
  validates :name, :length => {:in => 3..80}

  # TODO: 'organization with id 99' made only sense in 9+ million apphera system


  def create_schedule
    payload = {keyword: self.name, keyword_id: self.id, count: 0}.to_json
    Schedule.create!(name: "ranks", organization_id: 99, sequence_id: 7, description: payload, scheduled: DateTime.now - 5.minutes, in_progress: false)
  end

  def schedule_all
    Keyword.all.each do |k|
      payload = {keyword: k.name, keyword_id: k.id, count: 0}.to_json
      Schedule.create!(name: "ranks", organization_id: 99, sequence_id: 7, description: payload, scheduled: DateTime.now - 5.minutes, in_progress: false)
    end
  end
end
