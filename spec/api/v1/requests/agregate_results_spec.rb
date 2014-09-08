require 'spec_helper'

describe "AgregateResults" do
  describe "GET /agregate_results" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get agregate_results_path
      response.status.should be(200)
    end
  end
end
