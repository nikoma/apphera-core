class Campaign < ActiveRecord::Base
  belongs_to :account
  has_and_belongs_to_many :keywords, :uniq => true
  attr_accessible :name ,:account_id, :description, :start_date, :end_date
  validate :name, :description, required: true
end
