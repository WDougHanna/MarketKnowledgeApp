class UsersController < ApplicationController
    # before_action :set_user, except: [:new, :create, :home]
    before_action :set_user, only: [:show, :edit, :update, :destroy]
  
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        redirect_to leases_path 
      else
        @User = User.new
        render :new
      end
    end
  
    def destroy
      @user.destroy
      redirect_to login_path
    end
  
    private
  
    def set_user
      @user = User.find(params[:id])
    end
  
    def user_params
      params.require(:user).permit(:email, :password)
    end
  
  end