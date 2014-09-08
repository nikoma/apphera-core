class TaskResult < ActiveRecord::Base
  belongs_to :task
  belongs_to :organization
end
