class ContentProvider < ActiveRecord::Base
  attr_accessible :id, :name, :description, :url, :created_at, :updated_at
  has_many :ratings
  has_many :reviewers
  has_many :reviews
  has_and_belongs_to_many :proxies

  def self.cp(contentprovider)
    where("name = ?", contentprovider).first
  end


end
