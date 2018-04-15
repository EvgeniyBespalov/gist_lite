class GistsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_action :set_user
  before_action :set_gist, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @gist_error = params[:gist_error]
    @gists = Gist.all
    respond_with(@gists)
  end

  def show
    respond_with(@gist)
  end

  def new
    @gist = Gist.new
    respond_with(@gist)
  end

  def edit
    @gist_error = params[:gist_error]
  end

  def create
    @gist = Gist.new(gist_params)
    @gist.user = @user
    @gist.save
    respond_with(@gist)
  end

  def update
    if @user != @gist.user
      @error = "Access denied"
      redirect_to edit_gist_path @gist, error: @error
    else
      @gist.update(gist_params)
      respond_with(@gist)
    end
  end

  def destroy
    if @user != @gist.user
      @error = "Access denied"
      redirect_to gists_path error: @error
    else
      @gist.destroy
      respond_with(@gist)
    end
  end

  private
    def set_user
      @user = current_user    
    end
    
    def set_gist
      @gist = Gist.find(params[:id])
    end

    def gist_params
      params.require(:gist).permit(:file_name, :text)
    end
end
