class Plan < ActiveRecord::Base
  attr_accessible :name, :price
  has_many :subscriptions
end
