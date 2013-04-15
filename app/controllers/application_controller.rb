class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def authorize
    if !session[:user_id]
      redirect_to login_path
    end
  end
  
end
