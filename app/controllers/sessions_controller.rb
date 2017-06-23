class SessionsController < ApplicationController

  def new
    #redirect option to previous page after login
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      #log_in(user)  check session helper
      log_in @user
      #using Helper
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      #check session_helper
      redirect_back_or @user
    else
      #flash.now works with rendering (when no redirect)
      flash.now[:danger]  = "ترکیب پست الکترونیک/رمز عبور نامعتبر است."
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?  #Prevent error. if user logged out already
    #TODO some message or stuff here
    redirect_to root_url
  end
end