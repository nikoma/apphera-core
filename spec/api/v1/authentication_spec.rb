require "spec_helper"


describe "API errors", :type => :api do

  it "making a request without token" do
    get "/api/v1/items", :token => ""
    error = {:error => "Token is invalid."}
    last_response.body.should eql(error.to_json)
  end

end