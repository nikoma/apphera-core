require 'active_support'
require 'rspec/rails'
require 'active_support/core_ext/integer/time'
require 'active_support/core_ext/numeric/time'


describe "Messages API" do
  it 'sends a list of messages' do
    #FactoryGirl.create_list(:account, 10)
    get '/api/v1/accounts'
    expect(response).to be_success # test for the 200 status-code
    expect(json['messages'].length).to eq(10) # check to make sure the right amount of messages are returned
  end
end