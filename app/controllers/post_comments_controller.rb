class PostCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @user = @book.user
    @post_comment = current_user.post_comments.new(post_comment_params)
    @post_comment.book_id = @book.id
    unless @post_comment.save
      render 'error'
    end
  end

  def destroy
    @post_comment = PostComment.find(params[:id]).destroy
    @post_comment.destroy
    @book = Book.find(params[:book_id])

  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
