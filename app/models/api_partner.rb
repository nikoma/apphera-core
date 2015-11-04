class ApiPartner < ActiveRecord::Base
  has_many :accounts
  has_many :analytics_ranges
  has_many :named_queries, :through => :accounts
  has_one :twitter_app_credential
  attr_accessible :name, :token, :partner_token, :callback_url
  after_create :add_token
  after_commit :flush_cache


  def create_token
    SecureRandom.uuid
  end

  def add_token
    self.token = create_token
  end

  def self.cached_where(token)
    Rails.cache.fetch([name, token]) { where(token: token) }
  end

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
end
