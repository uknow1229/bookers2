class TagsearchesController < ApplicationController
  def search
    @model = Book 
    @word = params[:content]
    @books = Book.where("tag LIKE?","%#{@word}%")
    render "tagsearches/tagsearch"
  end
end
