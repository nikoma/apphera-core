class FacebookItem < ActiveRecord::Base
  belongs_to :keyword
  attr_accessible :keyword_id, :body
end
