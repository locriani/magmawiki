require 'spec_helper'

describe UserSessionsController do
  describe "POST / (#create)" do
    it "should prepare a new UserSession object" do
      user_session = mock_model(UserSession)

      user_session.should_receive(:new)
      
      post :create, 'user_session' => { 'login' => 'something', 'password' => 'something_else'}
    end
  end
end