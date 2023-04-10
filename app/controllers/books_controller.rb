class BooksController < ApplicationController
  def new
    @books = Book.all
    @book = Book.new
  end

  def create
    book = Book.new(book_params)
    book.save
    redirect_to book_path(current_user)
  end

  def index
    @books = Book.all
    @users = User.all
  end

  def show
    @books = Book.all
    @book = current_user
    @user = User.find(params[:id])
  end

  def update
  end

  def edit
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :profile_image)
  end

end
