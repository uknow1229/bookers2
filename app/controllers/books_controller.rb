class BooksController < ApplicationController
 before_action :correct_user, only: [:edit, :update]

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = User.find(current_user.id)
    if @book.save
      redirect_to book_path(@book)
      flash[:notice] = "You have created book successfully."
    else
      @books = Book.all
      render :index
    end
  end

  def index
    @book = Book.new
    @books = Book.all
    # @user = User.find(current_user.id)
  end

  def show
    # @book_new = Book.new
    @book = Book.find(params[:id])
    # @user = User.find(params[:id])
    @user = @book.user
    # @book.user_id = current_user.id
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render :edit
    else
      redirect_to books_path
    end
  end

  def destroy
    if @book = Book.find(params[:id])
       @book.destroy
      redirect_to books_path
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :profile_image)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end


end
