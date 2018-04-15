class GistsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_action :set_gist, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @gists = Gist.all
  end

  def show
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
      redirect_to gist_path @gist
    else
      render "new"
    end
  end

  def update
    if current_user == @gist.user
      unless @gist.update(gist_params)
        render "edit"
        return
      end
    else
      flash[:gist_error] = "Access denied"
    end   
    
    redirect_to gist_path @gist
  end

  def destroy
    if current_user == @gist.user
      @gist.destroy
      redirect_to gists_path
    else
      flash[:gist_error] = "Access denied"
      redirect_to gist_path @gist
    end
  end

  private
    
    def set_gist
      @gist = Gist.find(params[:id])
    end

    def gist_params
      params.require(:gist).permit(:file_name, :text)
    end
end
