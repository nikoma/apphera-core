class Proxy < ActiveRecord::Base
  attr_accessible :id, :content_providers, :port, :tested, :bad, :ip
  validates_uniqueness_of :ip
  has_and_belongs_to_many :content_providers
end
