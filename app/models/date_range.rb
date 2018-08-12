class DateRange < ActiveRecord::Base
  has_many :analytics_results
  #attr_accessible :name, :description, :from, :to
end
