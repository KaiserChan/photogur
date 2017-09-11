class PicturesController < ApplicationController

  before_action :ensure_logged_in, except: [:show, :index]
  before_action :load_picture, only: [:show, :edit, :update, :destroy]
  before_action :ensure_user_owns_picture, only: [:show, :edit, :update, :destroy]

  def index
    @pictures = Picture.all
    @most_recent_pictures = Picture.most_recent_five
    # @older_than_one_month_pictures = Picture.created_one_month_ago(time)
    @calendar_year_pictures = Picture.pictures_created_in_year(2017)
  end

  # def index
  #   @pictures = Picture.all
  # end

  def show
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.new

    @picture.title = params[:picture][:title]
    @picture.artist = params[:picture][:artist]
    @picture.url = params[:picture][:url]
    @picture.user_id = current_user.id

    if @picture.save
      flash[:notice] = "New picture successfully added"
      redirect_to "/pictures"   # <- if picture gets saved, generate a request to "/pictures"
    else
      render :new # <- otherwise render new.html.erb
    end
  end

  def edit
  end

  def update

    @picture.title = params[:picture][:title]
    @picture.artist = params[:picture][:artist]
    @picture.url = params[:picture][:url]

    if @picture.save
      redirect_to "/pictures/#{@picture.id}"
    else
      render :edit
    end
  end

  def destroy
    @picture.destroy
    redirect_to "/pictures"
  end

private

  def load_picture
    @picture = Picture.find(params[:id])
  end

  def ensure_user_owns_picture
    unless current_user == @picture.user
       flash[:alert] = "Please log in"
       redirect_to new_sessions_url
     end
  end

end
