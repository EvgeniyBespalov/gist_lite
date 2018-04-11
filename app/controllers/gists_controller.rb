class GistsController < ApplicationController
  before_filter :authenticate_user!, only: [:show, :edit, :create, :update, :destroy]
  before_action :set_user
  before_action :set_gist, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
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
  end

  def create
    @gist = Gist.new(gist_params)
    @gist.save
    respond_with(@gist)
  end

  def update
    @gist.update(gist_params)
    respond_with(@gist)
  end

  def destroy
    @gist.destroy
    respond_with(@gist)
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
