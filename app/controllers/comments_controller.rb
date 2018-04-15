class CommentsController < ApplicationController
  before_action :set_gist
  
  def create
    if current_user
      text = params[:comment]
      
      comment = Comment.new
      comment.text = text
      comment.user = current_user
      comment.gist = @gist
      
      comment.save
      
    end
    respond_to do |format|
      format.json { render json: {comment: comment, user_email: current_user.email}}
    end
  end
  
  private
  
  def set_gist
    @gist = Gist.find(params[:gist_id])
  end

end