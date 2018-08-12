class Ranking < ActiveRecord::Base
  belongs_to :organization
  belongs_to :keyword
  belongs_to :content_provider
  belongs_to :market
  #serialize :results, ActiveRecord::Coders::Hstore - changed to JSON
  store_accessor :ranks, :results
  #attr_accessible :rank, :content_provider, :organization_id, :keyword_id, :url, :name, :token, :results, :ranks, :market_id

end
