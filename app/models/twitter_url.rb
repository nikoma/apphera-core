class TwitterUrl < ActiveRecord::Base
  has_and_belongs_to_many :organizations
  attr_accessible :url
  validates_uniqueness_of :url
  has_many :twitter_counts
end
