class SessionsController < ApplicationController
  skip_before_filter :authorize

  def new
  end

  def create
    user = User.authenticate(params[:username], params[:password])
  
    if user && user.active?
      session[:user_id] = user.id
      redirect_to root_url
    else
      flash.now.alert = "Invalid Username and/or Password"
      render "new"
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "You have successfully logged out"
  end

end
