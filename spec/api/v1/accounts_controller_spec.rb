require 'spec_helper'

describe Api::V1::AccountsController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # Account. As you add validations to Account, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    FactoryGirl.build(:account).attributes
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AccountsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all accounts as @accounts" do
      account = FactoryGirl.create(:account)
      get "/api/v1/accounts", {}, valid_session
      parsed_body = JSON.parse(response.body)
      parsed_body["name"].should == "Test Company"

    end
  end

  describe "GET show" do
    it "assigns the requested account as @account" do
      account = Account.create! valid_attributes
      get :show, {:id => account.to_param}, valid_session
      assigns(:account).should eq(account)
    end
  end

  describe "GET new" do
    it "assigns a new account as @account" do
      get :new, {}, valid_session
      assigns(:account).should be_a_new(Account)
    end
  end

  describe "GET edit" do
    it "assigns the requested account as @account" do
      account = Account.create! valid_attributes
      get :edit, {:id => account.to_param}, valid_session
      assigns(:account).should eq(account)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Account" do
        expect {
          post :create, {:account => valid_attributes}, valid_session
        }.to change(Account, :count).by(1)
      end

      it "assigns a newly created account as @account" do
        post :create, {:account => valid_attributes}, valid_session
        assigns(:account).should be_a(Account)
        assigns(:account).should be_persisted
      end

      it "redirects to the created account" do
        post :create, {:account => valid_attributes}, valid_session
        response.should redirect_to(Account.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved account as @account" do
        # Trigger the behavior that occurs when invalid params are submitted
        Account.any_instance.stub(:save).and_return(false)
        post :create, {:account => {}}, valid_session
        assigns(:account).should be_a_new(Account)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Account.any_instance.stub(:save).and_return(false)
        post :create, {:account => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested account" do
        account = Account.create! valid_attributes
        # Assuming there are no other accounts in the database, this
        # specifies that the Account created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Account.any_instance.should_receive(:update_attributes).with({"these" => "params"})
        put :update, {:id => account.to_param, :account => {"these" => "params"}}, valid_session
      end

      it "assigns the requested account as @account" do
        account = Account.create! valid_attributes
        put :update, {:id => account.to_param, :account => valid_attributes}, valid_session
        assigns(:account).should eq(account)
      end

      it "redirects to the account" do
        account = Account.create! valid_attributes
        put :update, {:id => account.to_param, :account => valid_attributes}, valid_session
        response.should redirect_to(account)
      end
    end

    describe "with invalid params" do
      it "assigns the account as @account" do
        account = Account.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Account.any_instance.stub(:save).and_return(false)
        put :update, {:id => account.to_param, :account => {}}, valid_session
        assigns(:account).should eq(account)
      end

      it "re-renders the 'edit' template" do
        account = Account.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Account.any_instance.stub(:save).and_return(false)
        put :update, {:id => account.to_param, :account => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested account" do
      account = Account.create! valid_attributes
      expect {
        delete :destroy, {:id => account.to_param}, valid_session
      }.to change(Account, :count).by(-1)
    end

    it "redirects to the accounts list" do
      account = Account.create! valid_attributes
      delete :destroy, {:id => account.to_param}, valid_session
      response.should redirect_to(accounts_url)
    end
  end

end
