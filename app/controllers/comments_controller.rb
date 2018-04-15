class CommentsController < ApplicationController
  before_action :set_user
  before_action :set_gist
  
  def create
    if @user != nil

      text = params[:comment]
      
      comment = Comment.new
      comment.text = text
      comment.user = @user
      comment.gist = @gist
      
      comment.save
      
    end
    respond_to do |format|
      format.json { render json: {comment: comment, user_email: @user.email}}
    end
  end
  
  private
  
  def set_gist
    @gist = Gist.find(params[:gist_id])
  end

  def set_user
    @user = current_user 
  end

end