class Geodata < ActiveRecord::Base
  attr_accessible :areacode, :city, :country, :latitude, :longitude, :metrocode, :postalcode, :region
end
