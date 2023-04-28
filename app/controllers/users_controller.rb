class UsersController < ApplicationController
  # before_action :is_matching_login_user, only:[:edit, :update]

  def new
  end

  def create
    @user = User.find(params[:id])
    @user.save
    redirect_to user_path(current_user.id)
  end

  def index
    @users = User.all
    @book = Book.new
    @user = User.find(current_user.id)
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
    @following_users = @user.following_user
    @follower_users = @user.follower_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def edit
    user = User.find(params[:id])
  unless user.id == current_user.id
    redirect_to user_path(current_user)
  end
    @user = User.find(params[:id])
  end

  def follows
    user = User.find(params[:id])
    @users = user.following_user.page(params[:page]).per(3).reverse_order
  end

  def followers
    user = User.find(params[:id])
    @user = user.follower_user.page(params[:page]).per(3).reverse_order
  end

  private
  def user_params
    params.require(:user).permit(:name, :title, :introduction, :profile_image)
  end

  # def is_matching_login_user
  #   user = User.find(params[:id])
  #   user.id == current_user.id
  # end

end
