class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = I18n.t 'user.create.success'
      redirect_to root_url
    else
      render :action => :new
    end
  end
  
  def edit
    # unless current_user.permissions.edit_other_users?
    @user = current_user
    # else
    # @user = User.find(params[:id])
    # end
  end
  
  def update
    current_user.preferences[:locale] = params[:user][:locale]
    flash[:notice] = I18n.t 'user.update.success'
    redirect_to root_url
  end
end
