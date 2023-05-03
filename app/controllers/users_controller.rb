class UsersController < ApplicationController
  # before_action :is_matching_login_user, only:[:edit, :update]

  def new
  end

  def create
    @user = User.find(params[:id])
    @user.save
    redirect_to user_path(current_user.id)
  end


  # page
  def index
    @users = User.all
    @book = Book.new
    @user = User.find(current_user.id)
    # @groups = Group.all
    # @data = [['6日前', @books.created_6days.count],['5日前', @books.created_5days.count],['4日前', @books.created_4days.count],['3日前', @books.created_3days.count],['2日前', @books.created_2days.count]]
  end

  # page
  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
    @following_users = @user.following_user
    @follower_users = @user.follower_user
    @today_book = @books.created_today
    @yesterday_book = @books.created_yesterday
    @this_week_book = @books.created_this_week
    @last_week_book = @books.created_last_week
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
    @users = user.following_user
  end

  def followers
    user = User.find(params[:id])
    @user = user.follower_user
  end

  # button action
  def search_form
    @user = User.find(params[:user_id]) 
    @books = @user.books.where(created_at: params[:created_at].to_date.all_day)
    render :search_form
  end

  private
  def user_params
    params.require(:user).permit(:name, :title, :introduction, :profile_image )
  end

  # def is_matching_login_user
  #   user = User.find(params[:id])
  #   user.id == current_user.id
  # end

end
