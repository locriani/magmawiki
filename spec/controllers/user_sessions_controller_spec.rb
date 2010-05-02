require 'spec_helper'

describe UserSessionsController do
  integrate_views
  
  it "should redirect to index with a notice on successful login" do
    UserSession.stubs(:valid?).returns(true)

    post :create
    
    flash[:notice].should_not be_nil
    response.should redirect_to(root_path)
  end
  
  it "should re-render new template on failed login" do
    UserSession.stubs(:valid?).returns(false)
    
    post :create
    
    flash[:notice].should_not be_nil
    response.should render_template('new')
  end
end