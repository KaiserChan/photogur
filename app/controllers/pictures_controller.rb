class PicturesController < ApplicationController

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
    @picture = Picture.find(params[:id])
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.new

    @picture.title = params[:picture][:title]
    @picture.artist = params[:picture][:artist]
    @picture.url = params[:picture][:url]

    if @picture.save
      flash[:notice] = "New picture successfully added"
      redirect_to "/pictures"   # <- if picture gets saved, generate a request to "/pictures"
    else
      render :new # <- otherwise render new.html.erb
    end
  end

  def edit
    @picture = Picture.find(params[:id])
  end

  def update
    @picture = Picture.find(params[:id])

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
    @picture = Picture.find(params[:id])
    @picture.destroy
    redirect_to "/pictures"
  end

end
