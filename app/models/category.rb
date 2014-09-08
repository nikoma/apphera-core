class Category < ActiveRecord::Base
  has_many :organizations
  attr_accessible :name, :country_id, :id
  belongs_to :country
end
