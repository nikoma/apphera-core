class Task < ActiveRecord::Base
  has_paper_trail
  has_many :task_results
  has_many :task_translations
  has_many :organizations, :through => :task_results
end
