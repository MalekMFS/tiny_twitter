class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      flash[:success] = "حساب کاربری شما فعال شد!"
      log_in user
      redirect_to user
    else
      flash[:danger] = "پیوند فعالسازی نامعتبر است!"
      redirect_to root_url
    end
  end
end
