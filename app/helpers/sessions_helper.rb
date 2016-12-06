module SessionsHelper
#This module (helper) included in app controller

  #logs in the given user
  def log_in(user)
    #user.id will be used in url And,
    #in real world we don't want it.
    #people will know how many users we have!
    session[:user_id] = user.id
  end

  #Remembers a user in a persistent session.
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  #Returns the current logged-in user (if Any).
  def current_user
    if (user_id = session[:user_id])
      #Prevent database call spam by using an
      #instance variable *(memoization)*
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    session.delete(:user_id) # session[:user_id] = nil
    @current_user = nil
  end

end
