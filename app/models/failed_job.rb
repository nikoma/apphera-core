class FailedJob < ActiveRecord::Base
  # Used in scaled out solutions when Apphera 'observer' is running
  #attr_accessible :organization_id, :reason, :retry_count, :schedule_id

end
