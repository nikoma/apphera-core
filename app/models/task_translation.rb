class TaskTranslation < ActiveRecord::Base
  has_paper_trail
  attr_accessible :body, :header, :language_id, :task_id
  belongs_to :task
end
