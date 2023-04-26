class FavoritesController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
    favorites.new
    redirect_to book_path(book)
  end

  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
    favorites.destroy
    redirect_to book_path(book)
  end
end
