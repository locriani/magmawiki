class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = I18n.t 'user.create_message'
      redirect_to root_url
    else
      render :action => :new
    end
  end
  
  def edit
    # unless current_user.permissions.edit_other_users?
      @user = current_user
    # end
  end
  
  def update
    
  end
end
