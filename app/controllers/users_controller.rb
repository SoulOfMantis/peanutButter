class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[ show ]
  before_action :resume_session, :set_user, only: %i[ show edit update destroy ] 
  
  def show
    @user = User.find_by nickname: params[:nickname]
  end

  def update
    if !@user.is_current?
      redirect_to @user, status: :forbidden
    end
   
    if @user.update user_params
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
    if !@user.is_current?
      redirect_to @user, status: :forbidden
    end
  end

  def destroy    
    if !@user.is_current?
      redirect_to @user, status: :forbidden and return
    end

    @user.destroy
  end
  
  private
    def set_user
      @user = User.find_by nickname: params[:nickname]      
    end

    def user_params
      params.expect(user: [ :name, :description ])
    end

end
