class OrganizationLink < ActiveRecord::Base

  after_create :extract_slugs

  #attr_accessible :bing_display_url, :bing_id, :description, :organization_id, :title, :url
  belongs_to :organization
  validates_uniqueness_of :bing_id

  # TODO: load slug keys from db

  def extract_slugs
    @cp = {:google_germany => 8, :kennstdueinen => 12, :tripadvisor => 7, :bing => 6, :pointoo => 13, :qype => 10, :golocal => 14, :hotels => 15, :meinestadt => 16, :restaurantkritik => 17, :wowarstdu => 18, :yahoo => 32, :urbanspoon => 3, :yellowpages => 4, :yelp => 5, :cars => 19, :superpages => 20, :zillow => 21, :resellerrating => 22, :kudzu => 23, :merchantcircle => 24, :insiderpages => 25, :zocdoc => 26}
    @cp_urls = {:kennstdueinen => "kennstdueinen.de", :tripadvisor => "tripadvisor.com", :pointoo => "pointoo.de", :qype => "qype.com", :golocal => "golocal.com", :hotels => "hotels.com", :meinestadt => "meinestadt.de", :yahoo => "local.yahoo.com", :restaurantkritik => "restaurant-kritik.de", :wowarstdu => "wowarstdu.de", :urbanspoon => "urbanspoon.com", :yellowpages => "yellowpages.com", :yelp => "yelp.com", :cars => "cars.com", :superpages => "superpages.com", :zillow => "zillow.com", :resellerrating => "resellerrating.com", :kudzu => "kudzu.com", :merchantcircle => "merchantcircle.com", :insiderpages => "insiderpages.com", :zocdoc => "zocdoc.com"}
    @cp_urls.each do |k, v|
      if self.url.include? v
        ProviderSlug.create!(organization_id: self.organization_id, content_provider_id: @cp[k], slug: self.url, bad: false)
      end
    end
  end
end
