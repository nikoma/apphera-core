#!ruby19
# encoding: utf-8
require 'uri'
require 'net/http'
require 'open-uri'
require 'httparty'
require 'json'

class BingApi
  include HTTParty
  include Sidekiq::Worker

  def search(query, country)
    puts "running query"
    query_encoded = URI.escape(query)
    auth = {:username => "", :password => ENV["BING_KEY"]}
    options = {:basic_auth => auth}
    base_uri = "https://api.datamarket.azure.com/Data.ashx/Bing/Search/Web?Query=%27#{query_encoded.to_s}%27&Market=%27#{country}%27&$top=50&$format=Json"
    puts base_uri rescue nil
    response = HTTParty.get(base_uri, options)
    response.body rescue nil
    #puts response.body rescue nil
  end

  def perform(org_id)
    puts "running query for #{org_id.to_s}"
    @org = Organization.find org_id
    @org_id = org_id
    @country = "de-DE"
    if @org.country_code_id == 228
      @country = "en-US"
    end
    if @org.country_code_id == 103
      @country = "en-IN"
    end
    @keyword = "#{@org.name}, #{@org.street}, #{@org.city}"
    answer = JSON.parse(BingApi.new.search @keyword, @country)
    answer['d']['results'].each do |r|
      p r['Url']
      OrganizationLink.create_with(:organization_id => @org_id, bing_id: r['ID'], bing_display_url: r['DisplayUrl'], description: r['Description'], title: r['Title']).find_or_create_by(url: r['Url']) rescue nil
      @cp = {:google_germany => 8, :kennstdueinen => 12, :tripadvisor => 7, :bing => 6, :pointoo => 13, :qype => 10, :golocal => 14, :hotels => 15, :meinestadt => 16, :restaurantkritik => 17, :wowarstdu => 18, :yahoo => 32, :urbanspoon => 3, :yellowpages => 4, :yelp => 5, :cars => 19, :superpages => 20, :zillow => 21, :resellerrating => 22, :kudzu => 23, :merchantcircle => 24, :insiderpages => 25, :zocdoc => 26, :zomato => 27}
      # cp_urls are used to find the google slugs
      @cp_urls = {:kennstdueinen => "kennstdueinen.de", :tripadvisor => "tripadvisor.com", :pointoo => "pointoo.de", :qype => "qype.com", :golocal => "golocal.com", :hotels => "hotels.com", :meinestadt => "meinestadt.de", :yahoo => "local.yahoo.com", :restaurantkritik => "restaurant-kritik.de", :wowarstdu => "wowarstdu.de", :urbanspoon => "urbanspoon.com", :yellowpages => "yellowpages.com", :yelp => "yelp.com", :cars => "cars.com", :superpages => "superpages.com", :zillow => "zillow.com", :resellerrating => "resellerrating.com", :kudzu => "kudzu.com", :merchantcircle => "merchantcircle.com", :insiderpages => "insiderpages.com", :zocdoc => "zocdoc.com", :zomato => "zomato.com"}
      @cp_urls.each do |a, b|
        if r['Url'].include? b
          newslug = ProviderSlug.new(:organization_id => @org_id, :content_provider_id => @cp[a], :slug => r['Url'], :bad => 0)
          newslug.save unless newslug.slug.include? "sitemap"
        end
      end
    end
  end
end