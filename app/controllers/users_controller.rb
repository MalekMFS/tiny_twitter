 class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.all.paginate(page: params[:page], per_page: 30)
  end
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    #debugger
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "به #{$APP_NAME} خوش آمدید."
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    #suppling @user by correct_user
    #@user = User.find(params[:id])
  end

  def update
    #@user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "ویرایش نمایه با موفقیت انجام شد."
      #redirect_back(fallback_location: @user)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id]).destroy
    flash[:success] = "کاربر '#{user.name}' حذف گردید!"
    redirect_to users_url
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
    end

    # before field_with_errors
    # Confirm a logged in users
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "لطفاً وارد شوید!"
        redirect_to login_url
      end
    end
    #confirm the correct user
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
