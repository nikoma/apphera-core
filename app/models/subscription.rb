class Subscription < ActiveRecord::Base
  # Part of payments for SaaS solutions
  belongs_to :plan
  belongs_to :user
  validates_presence_of :plan_id

  attr_accessible :plan_id, :user_id, :updated_at
end
