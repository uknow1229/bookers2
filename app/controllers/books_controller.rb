class BooksController < ApplicationController
  def new
    @book = Book.all
  end

  def index
    @book = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
  end
end
