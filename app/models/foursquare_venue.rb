class FoursquareVenue < ActiveRecord::Base
  belongs_to :organization, :foreign_key => "organization_id", :primary_key => "id"
  has_many :foursquare_counts
  attr_accessible :foursquare_id, :name, :phone, :category, :organization_id, :top_category, :address, :city, :postalcode, :state, :lat, :lng

end
