#encoding: utf-8 TODO: move requirements into gemfile after tests
require 'uri'
require 'net/http'
require 'open-uri'
require 'httparty'
require 'json'


class BingKeywords
  include HTTParty
  include Sidekiq::Worker

  def Hash.new_nested_hash

    Hash.new { |h, k| h[k]=Hash.new(&h.default_proc) }

  end

  def search(query, country)
    # puts "running query"
    query_encoded = URI.escape(query)
    auth = {:username => "", :password => ENV["BING_KEY"]}
    options = {:basic_auth => auth}
    base_uri = "https://api.datamarket.azure.com/Data.ashx/Bing/Search/Web?Query=%27#{query_encoded.to_s}%27&Market=%27#{country}%27&$top=50&$format=Json"
    # puts base_uri rescue nil
    response = HTTParty.get(base_uri, options)
    response.body rescue nil
    #puts response.body rescue nil
  end

  def perform(keyword_id, market)
    # puts "running query for #{keyword_id.to_s}"
    @key = Keyword.find keyword_id
    @country = Market.where(name: market).first
    @keyword = "#{@key.name}"
    answer = JSON.parse(BingApi.new.search @keyword, @country.name)
    res = []
    a = 0
    answer['d']['results'].each do |r|
      a += 1
      h = {} #Hash.new_nested_hash
      p "the raw link : " + r['DisplayUrl']
      h["ranking"] = a
      h["title"] = r['Title']
      h["link_text"] = r['DisplayUrl']
      h["link"] = r['Url']
      res << h
    end
    p '---------------------'
    p "now comes json"

    result_hash = Hash.new_nested_hash
    result_hash["date"] = DateTime.now
    result_hash["Keyword"] = @key.name
    result_hash["results"] = res
    json = result_hash.to_json

    Ranking.create!(keyword_id: @key.id, ranks: json, market_id: @country.id)
  end
end


