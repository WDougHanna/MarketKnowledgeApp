class SessionsController < ApplicationController

    def new
      @user = User.new
      @users = User.all
    end
  
    def create
      if access_token = request.env["omniauth.auth"] # this is not set up
        user = User.make_omni_user(access_token)
        session[:user_id] = user.id
        redirect_to leases_path
      else
        user = User.find_by(:email => params[:user][:email])
        if user && user.authenticate(params[:user][:password])
          session[:user_id] = user.id
          redirect_to leases_path
        else
          @user = User.new
          @users = User.all
          flash[:notice] = "Incorrect Password"
          render 'sessions/new'
        end
      end
    end
  
    def destroy
      session[:user_id] = nil
      redirect_to root_url
    end
  
  end