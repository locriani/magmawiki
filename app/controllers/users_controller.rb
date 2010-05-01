class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if CAPTCHA.verify_recaptcha(:model => @user, :message => (I18n.t 'recaptcha.error')) && @user.save
      flash[:notice] = I18n.t 'user.create_message'
      redirect_to root_url
    else
      render :action => :new
    end
  end
end
