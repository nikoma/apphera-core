class FoursquareCount < ActiveRecord::Base
  #attr_accessible :foursquare_venue_id, :checkins_count, :users_count, :tip_count
  belongs_to :foursquare_venue
end
