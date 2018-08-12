class Division < ActiveRecord::Base
  belongs_to :country
  has_many :cities
  #attr_accessible :full_code, :name, :ascii_name, :geonames_id
end