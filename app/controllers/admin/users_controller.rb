class Admin::UsersController < ApplicationController
  before_action :if_not_admin
  before_action :set_user, only: [:show, :edit, :destroy, :update]

  def index
     @users = User.all.includes(:tasks)
   end

   def new
     if logged_in?
       @tasks = Task.all
       render 'pictures/index'
     else
       @user = User.new
       render 'new'
     end
   end

   def create
     @user = User.new(user_params)

     if @user.save
       flash[:notice] = 'ユーザーを作成しました'
       redirect_to admin_users_path
     else
       render :new
     end

   end

   def show
   end

   def edit
   end

   def update
     if @user.update(user_params)
       redirect_to admin_user_path(@user), notice: t('view.user.edit_message')
     else
       render :edit
     end
   end

   def destroy
     if @user.destroy
       flash[:notice] = t('view.user.destroy_message')
       redirect_to admin_users_path
     else
       flash[:notice] = t('view.user.destroy_error')
       redirect_to admin_users_path
     end
   end

  private

  def if_not_admin
    unless current_user.admin?
      flash[:notice] = 'あなたは管理者ではありません'
      redirect_to root_path
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end
end
