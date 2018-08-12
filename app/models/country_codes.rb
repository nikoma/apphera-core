class CountryCodes < ActiveRecord::Base
  #attr_accessible :code, :name
  has_many :organizations, :foreign_key => "country_code_id"

  def self.select_codes
    self.all.map { |item| [item.name, item.code] }
  end

  def self.select_countries
    self.all.map { |item| [item.name, item.id] }
  end
end
