class Admin::MoviesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!
  
  def index
    @movies = Movie.all.page(params[:page]).per(20)
  end
  
  def show
    @movie = Movie.friendly.find(params[:id])
  end
  
  def new
    @movie = Movie.new
    @genres = Genre.all
  end
  
  def create
    @movie = Movie.new(movie_params)
    @genres = Genre.all
    
    if @movie.save
      redirect_to admin_movie_path(@movie), notice: 'Movie was successfully created.'
    else
      render :new
    end
  end
  
  def edit
    @movie = Movie.friendly.find(params[:id])
    @genres = Genre.all
  end
  
  def update
    @movie = Movie.friendly.find(params[:id])
    
    if @movie.update(movie_params)
      redirect_to admin_movie_path(@movie), notice: 'Movie was successfully updated.'
    else
      @genres = Genre.all
      render :edit
    end
  end
  
  def destroy
    @movie = Movie.friendly.find(params[:id])
    @movie.destroy
    redirect_to admin_movies_path, notice: 'Movie was successfully deleted.'
  end
  
  private
  
  def movie_params
    params.require(:movie).permit(
      :title, :description, :genre_id, :duration, :release_year, 
      :imdb_rating, :poster_url, :trailer_url, :country, :director, :cast,
      :thumbnail, :video,
      :enable_ads, :ad_frequency, :enable_download, :download_quality, :download_price,
      ads_attributes: [:title, :url, :duration, :position, :script]
    )
  end
  
  def require_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: 'Access denied. Admin privileges required.'
    end
  end
end
