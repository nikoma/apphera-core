class Market < ActiveRecord::Base
  attr_accessible :name, :language
  has_many :rankings
end
