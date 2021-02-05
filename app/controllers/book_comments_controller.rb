class BookCommentsController <

  def create
    @book_comment = BookComment.new(comment_params)
    @book_comment.user_id = current_user.id
    if @book_comment.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end

  end

  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
