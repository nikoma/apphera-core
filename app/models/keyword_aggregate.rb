class KeywordAggregate < ActiveRecord::Base
  #attr_accessible :keyword_id, :aggregates
  belongs_to :keyword
end
