class FacebookUrl < ActiveRecord::Base
  has_and_belongs_to_many :organizations
  attr_accessible :url
  validates_uniqueness_of :url
  accepts_nested_attributes_for :organizations
end
