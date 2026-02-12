class Admin::MoviesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin_role
  layout 'admin'
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  def index
    @movies = Movie.includes(:genre, :user).all.page(params[:page])
  end

  def show
  end

  def new
    @movie = Movie.new
    @movie.ads.build # Build an empty ad for the form
    @genres = Genre.all
  end

  def edit
    @movie.ads.build # Build an empty ad for the form
    @genres = Genre.all
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.user = current_user

    respond_to do |format|
      if @movie.save
        format.html { redirect_to admin_movie_path(@movie), notice: 'Movie was successfully created.' }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream
      end
    end
  end

  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to admin_movie_path(@movie), notice: 'Movie was successfully updated.' }
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream
      end
    end
  end

  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to admin_movies_url, notice: 'Movie was successfully destroyed.' }
      format.turbo_stream { head :ok }
    end
  end

  private

  def set_movie
    @movie = Movie.friendly.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(
      :title, :genre_id, :release_year, :duration, :imdb_rating, :country, 
      :director, :cast, :description, :thumbnail, :video, :poster_url, 
      :trailer_url, :enable_ads, :ad_frequency, 
      :enable_download, :download_quality, :download_price,
      ads_attributes: [:id, :title, :url, :duration, :position, :script, :active, :_destroy]
    )
  end

  def check_admin_role
    unless current_user&.admin?
      redirect_to root_path, alert: 'Access denied.'
    end
  end
end