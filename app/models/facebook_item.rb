class FacebookItem < ActiveRecord::Base
  belongs_to :keyword
  #attr_accessible :keyword_id, :body, :sentiment
  before_save :predict

  def predict
    self.sentiment  = DictionarySentiment.new.classify("en", self.body["message"])[:sentiment].to_f || 0.0
  end
end
