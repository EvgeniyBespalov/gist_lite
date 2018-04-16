class CommentsController < ApplicationController
  before_filter :authenticate_user!, only: [:create]
  
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    
    
    
    @comment.save
    redirect_to gist_path(@comment.gist)
    
  end  
  
  
  private
  
  def comment_params
    params.require(:comment).permit(:text, :gist_id)
  end

end