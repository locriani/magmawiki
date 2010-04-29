class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if verify_recaptcha(:model => @user, :message => "You input recaptcha wrong stuff") && @user.save
      flash[:notice] = "Registration successful"
      redirect_to root_url
    else
      render :action => :new
    end
  end
end
