require 'spec_helper'

describe "/api/v1/items", :type => :api do
  let(:project) { Factory(:item, :subject => "New alert!") }

  before do
    @user = create_user!
    @user.update_attribute(:admin, true)
    @user.permissions.create!(:action => "view",
                              :thing => item)
  end

  let(:token) { @user.authentication_token }

  context "index" do
    before do
      5.times do
        Factory(:item, :item => item, :user => @user)
      end
    end

    let(:url) { "/api/v1/items/#{project.id}/items" }


    it "JSON" do
      get "#{url}.json", :token => token
      last_response.body.should eql(project.items.to_json)
    end
  end
end