class SessionsController < ApplicationController
  def new
  end

  def create
    user = login(params[:username], params[:password], params[:remember_me])
    if user
      redirect_back_or_to root_url, :notice => t('auth.logged_in')
    else
      flash.now.alert = t('auth.invalid')
    end
  end
  
  def destroy
    logout
    redirect_to root_url, :notice => t('auth.logged_out')
  end
end
