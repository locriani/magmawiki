require File.dirname(__FILE__) + '/../spec_helper'

describe AuthenticationsController do
  fixtures :all
  render_views

  it "index action should render index template" do
    pending do
      get :index
      response.should render_template(:index)
    end
  end
  
  it "create action should render new template when model is invalid" do
    Authentication.any_instance.stubs(:valid?).returns(false)
    pending do
      post :create
      response.should render_template(:new)
    end
  end

  it "create action should redirect when model is valid" do
    Authentication.any_instance.stubs(:valid?).returns(true)
    pending do
      post :create
      response.should redirect_to(authentications_url)
    end
  end
  
  it "destroy action should destroy model and redirect to index action" do
    pending do
      authentication = Authentication.first
      delete :destroy, :id => authentication
      response.should redirect_to(authentications_url)
      Authentication.exists?(authentication.id).should be_false
    end
  end
end
