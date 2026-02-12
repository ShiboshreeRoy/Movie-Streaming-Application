class Admin::TvShowsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!
  
  def index
    @tv_shows = TvShow.all.page(params[:page]).per(20)
  end
  
  def show
    @tv_show = TvShow.friendly.find(params[:id])
  end
  
  def new
    @tv_show = TvShow.new
    @genres = Genre.all
  end
  
  def create
    @tv_show = TvShow.new(tv_show_params)
    @genres = Genre.all
    
    if @tv_show.save
      redirect_to admin_tv_show_path(@tv_show), notice: 'TV show was successfully created.'
    else
      render :new
    end
  end
  
  def edit
    @tv_show = TvShow.friendly.find(params[:id])
    @genres = Genre.all
  end
  
  def update
    @tv_show = TvShow.friendly.find(params[:id])
    
    if @tv_show.update(tv_show_params)
      redirect_to admin_tv_show_path(@tv_show), notice: 'TV show was successfully updated.'
    else
      @genres = Genre.all
      render :edit
    end
  end
  
  def destroy
    @tv_show = TvShow.friendly.find(params[:id])
    @tv_show.destroy
    redirect_to admin_tv_shows_path, notice: 'TV show was successfully deleted.'
  end
  
  private
  
  def tv_show_params
    params.require(:tv_show).permit(
      :title, :description, :genre_id, :seasons, :episodes, :release_year, 
      :imdb_rating, :poster_url, :trailer_url, :country,
      :thumbnail, :video
    )
  end
  
  def require_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: 'Access denied. Admin privileges required.'
    end
  end
end