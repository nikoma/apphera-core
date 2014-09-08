class CompleteReview < ActiveRecord::Base

  def self.result(rev_id)
    @obj = {}
    r = Review.find(rev_id)
    @obj[:review] = r
    @obj[:category] = r.organization.category
    @obj[:organization] = r.organization
    return @obj

  end

end
