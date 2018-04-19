class GistsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_action :set_gist, only: [:show, :edit, :update, :destroy]
  before_action :user_valid, only: [:update, :destroy]
  
  respond_to :html

  def index    
    if params[:gists] == "my" && current_user
      @gists = Gist.where(user: current_user)
    else      
      @gists = Gist.all
    end
  end

  def show
    @comment_new = Comment.new(gist: @gist) if current_user 
    #, user: current_user - пользователь не инициализируется так как при записи 
    #испольуется текущий пользователь
  end

  def new
    @gist = Gist.new
  end

  def edit
  end

  def create
    @gist = Gist.new(gist_params)
    @gist.user = current_user
    
    if @gist.save
      redirect_to gist_path(@gist)
    else
      render "new"
    end
  end

  def update    
    if @gist.update(gist_params)
      redirect_to gist_path(@gist)
    else
      render "edit"
    end
  end

  def destroy
    @gist.destroy
    redirect_to gists_path
  end

  private
    
  def set_gist
    @gist = Gist.includes(:user, comments: :user).find(params[:id])
  end

  def gist_params
    params.require(:gist).permit(:file_name, :text)
    puts "****"
    puts params
    puts "****"
    puts params.require(:gist).permit(:file_name, :text)
    puts "*********"
  end
  
  def user_valid
    if current_user != @gist.user
      flash[:error] = "Access denied"
      redirect_to gist_path(@gist)
      return
    end
  end
end
