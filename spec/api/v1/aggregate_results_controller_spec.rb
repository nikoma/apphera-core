require 'spec_helper'

describe Api::V1::AggregateResultsController, :type => :api do

  # This should return the minimal set of attributes required to create a valid
  # AgregateResult. As you add validations to AgregateResult, be sure to
  # update the return value of this method accordingly.
  #def valid_attributes
  #  {  }
  #end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AgregateResultsController. Be sure to keep this updated too.
  def valid_session
    FactoryGirl.build(:aggregate_results).attributes
  end

  describe "GET index" do
    it "assigns all agregate_results as @agregate_results" do
      agregate_result = AggregateResult.create! valid_attributes
      get :index, {}, valid_session
      assigns(:agregate_results).should eq([agregate_result])
    end
  end

  describe "GET show" do
    it "assigns the requested agregate_result as @agregate_result" do
      agregate_result = AggregateResult.create! valid_attributes
      get :show, {:id => agregate_result.to_param}, valid_session
      assigns(:agregate_result).should eq(agregate_result)
    end
  end

  describe "GET new" do
    it "assigns a new agregate_result as @agregate_result" do
      get :new, {}, valid_session
      assigns(:agregate_result).should be_a_new(AggregateResult)
    end
  end

  describe "GET edit" do
    it "assigns the requested agregate_result as @agregate_result" do
      agregate_result = AggregateResult.create! valid_attributes
      get :edit, {:id => agregate_result.to_param}, valid_session
      assigns(:agregate_result).should eq(agregate_result)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new AgregateResult" do
        expect {
          post :create, {:agregate_result => valid_attributes}, valid_session
        }.to change(AggregateResult, :count).by(1)
      end

      it "assigns a newly created agregate_result as @agregate_result" do
        post :create, {:agregate_result => valid_attributes}, valid_session
        assigns(:agregate_result).should be_a(AggregateResult)
        assigns(:agregate_result).should be_persisted
      end

      it "redirects to the created agregate_result" do
        post :create, {:agregate_result => valid_attributes}, valid_session
        response.should redirect_to(AggregateResult.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved agregate_result as @agregate_result" do
        # Trigger the behavior that occurs when invalid params are submitted
        AggregateResult.any_instance.stub(:save).and_return(false)
        post :create, {:agregate_result => {}}, valid_session
        assigns(:agregate_result).should be_a_new(AggregateResult)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        AggregateResult.any_instance.stub(:save).and_return(false)
        post :create, {:agregate_result => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested agregate_result" do
        agregate_result = AgregateResult.create! valid_attributes
        # Assuming there are no other agregate_results in the database, this
        # specifies that the AgregateResult created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        AgregateResult.any_instance.should_receive(:update_attributes).with({"these" => "params"})
        put :update, {:id => agregate_result.to_param, :agregate_result => {"these" => "params"}}, valid_session
      end

      it "assigns the requested agregate_result as @agregate_result" do
        agregate_result = AgregateResult.create! valid_attributes
        put :update, {:id => agregate_result.to_param, :agregate_result => valid_attributes}, valid_session
        assigns(:agregate_result).should eq(agregate_result)
      end

      it "redirects to the agregate_result" do
        agregate_result = AgregateResult.create! valid_attributes
        put :update, {:id => agregate_result.to_param, :agregate_result => valid_attributes}, valid_session
        response.should redirect_to(agregate_result)
      end
    end

    describe "with invalid params" do
      it "assigns the agregate_result as @agregate_result" do
        agregate_result = AgregateResult.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        AgregateResult.any_instance.stub(:save).and_return(false)
        put :update, {:id => agregate_result.to_param, :agregate_result => {}}, valid_session
        assigns(:agregate_result).should eq(agregate_result)
      end

      it "re-renders the 'edit' template" do
        agregate_result = AgregateResult.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        AgregateResult.any_instance.stub(:save).and_return(false)
        put :update, {:id => agregate_result.to_param, :agregate_result => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested agregate_result" do
      agregate_result = AgregateResult.create! valid_attributes
      expect {
        delete :destroy, {:id => agregate_result.to_param}, valid_session
      }.to change(AgregateResult, :count).by(-1)
    end

    it "redirects to the agregate_results list" do
      agregate_result = AgregateResult.create! valid_attributes
      delete :destroy, {:id => agregate_result.to_param}, valid_session
      response.should redirect_to(agregate_results_url)
    end
  end

end
