class UsersController < ApplicationController
  # before_action :is_matching_login_user, only:[:edit, :update]

  def new
  end

  def create
    @user = User.find(params[:id])
    @user.save
    flash[:notice] = "Welcome! You have signed up successfully."
    redirect_to user_path(current_user.id)
  end

  def index
    # @current_user_name = current_user.name if current_user
    @users = User.all
    # @user = current_user
    @book = Book.new
    @books = Book.all
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:title, :introduction, :profile_image)
  end

  # def is_matching_login_user
  #   user = User.find(params[:id])
  #   user.id == current_user.id
  # end

end
