class PasswordResetsController < ApplicationController
  before_action :get_user,         only: [:edit, :update]
  before_action :valid_user,       only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]
  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      #valid email address
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "نحوه تغییر رمزعبور به آدرس #{@user.email} ارسال شد!"
      redirect_to root_url
    else
      #invalid email address
      flash.now[:danger] = "پست الکترونیک پیدا نشد!"
      render 'new'
    end
  end

  def edit
  end

  def update
    #NOTE because we "allow_blank: true" in password validation
    if(params[:user][:password].blank?) #catch blank password & password_confirmation
       @user.errors.add(:password, "لطفاً رمزعبور مورد نظرتان را وارد کنید!")
       render 'edit'
    elsif @user.update_attributes(user_params) #Successful
      log_in @user
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = "رمزعبور با موفقیت تغییر کرد!"
      redirect_to @user
    else #Invalid password
      render 'edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  ##Before Filters##
  def get_user
    @user = User.find_by(email: params[:email])
  end
  #Confirms a valid user and correct reset_token
  def valid_user
    unless (@user && @user.activated? &&
            @user.authenticated?(:reset, params[:id]))
      redirect_to root_url
    end
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = "پیوند بازیابی رمزعبور باطل شده است! لطفاً دوباره درخواست کنید."
      redirect_to new_password_reset_url
    end
  end

end
