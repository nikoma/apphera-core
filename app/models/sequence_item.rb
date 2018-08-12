class SequenceItem < ActiveRecord::Base
  has_paper_trail
  has_and_belongs_to_many :sequences
  #attr_accessible :name, :description
end
