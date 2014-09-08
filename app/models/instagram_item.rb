class InstagramItem < ActiveRecord::Base
 attr_accessible :keyword_id, :body
  belongs_to :keyword
end

