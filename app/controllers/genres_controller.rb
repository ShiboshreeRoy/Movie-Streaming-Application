class GenresController < ApplicationController
  def index
    @genres = Genre.all.page(params[:page]).per(20)
  end
  
  def show
    @genre = Genre.friendly.find(params[:id])
    @movies = Movie.includes(:genre).by_genre(@genre.id).page(params[:page]).per(20)
    @tv_shows = TvShow.includes(:genre).by_genre(@genre.id).page(params[:page]).per(20)
  end
end
