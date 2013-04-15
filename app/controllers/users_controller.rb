class UsersController < ApplicationController
  before_filter :authorize, :only => [:index, :destroy, :edit, :update]
  
  def index
    @users = User.all
  
    respond_to do |format|
      format.html
    end
  end
  
  def new
    @user = User.new
    
    respond_to do |format|
      format.html
    end
  end
  
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to login_path, notice: 'User was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end
  
  def forgot_password
    if request.post?
      @user = User.find_by_email(params[:email])
    
      if @user
        flash[:notice] = "A link has been sent to your email to reset your password"
        @user.forgot_password!
        redirect_to login_path
      else
        flash[:alert] = "The email (#{params[:email]}) could not be found. Please create an account."
        redirect_to login_path
      end
    else
      render :template => "users/forgot_password"
    end
  end
  
  def reset_password
    @user = User.find_by_pwcode(params[:pw_code])
    
    if @user
      session[:user_id] = @user.id
      @user.update_attribute(:pwcode, nil)
      redirect_to :controller => "users", :action => "edit", :id => @user.id
    else
      flash[:alert] = "We couldn't find your account -- check your email?"
      redirect_to login_path
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_path }
    end
  end
  
end
