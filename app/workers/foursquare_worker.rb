class FoursquareWorker
  include Sidekiq::Worker

  def perform(org_id)
    puts "running foursquare worker"
    #@org_id = 10027
    @org = Organization.find(@org_id)
    @client = Foursquare2::Client.new(:client_id => ENV["FOURSQUARE_ID"], :client_secret => ENV["FOURSQUARE_SECRET"], :api_version => '20140606')
    res =@client.search_venues(:ll => "#{@org.latitude.to_s},#{@org.longitude.to_s}", :query => "#{@org.name}")
    puts "#{@org.lat_lon}"
    content = res.venues
    content.each do |c|
      begin
        if !c.name.include? @org.name
          fs = FoursquareVenue.create_with(:organization_id => @org.id, :name => c.name, :phone => c.contact.phone, :category => c.categories.first.name, :top_category => c.categories.first.parents, :address => c.location.address, :city => c.location.city, :postalcode => c.location.postalCode, :state => c.location.state, :lat => c.location.lat, :lng => c.location.lng).find_or_create_by(:foursquare_id => c.id)
          puts fs.to_s
          fs.save
          fc = FoursquareCount.new(:foursquare_venue_id => fs.id, :checkins_count => c.stats.checkinsCount, :users_count => c.stats.usersCount, :tip_count => c.stats.tipCount)
          fc.save
        else
          fs = FoursquareVenue.create_with(:organization_id => nil, :name => c.name, :phone => c.contact.phone, :category => c.categories.first.name, :top_category => c.categories.first.parents, :address => c.location.address, :city => c.location.city, :postalcode => c.location.postalCode, :state => c.location.state, :lat => c.location.lat, :lng => c.location.lng).find_or_create_by(:foursquare_id => c.id)
          puts fs.to_s
          fs.save
          fc = FoursquareCount.new(:foursquare_venue_id => fs.id, :checkins_count => c.stats.checkinsCount, :users_count => c.stats.usersCount, :tip_count => c.stats.tipCount)
          fc.save
        end
      rescue
      end
    end
  end
end