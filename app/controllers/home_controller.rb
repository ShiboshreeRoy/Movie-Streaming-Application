class HomeController < ApplicationController
  def index
    @featured_movies = Movie.includes(:genre).limit(6)
    @latest_movies = Movie.includes(:genre).order(created_at: :desc).limit(10)
    @top_rated_movies = Movie.includes(:genre).where.not(imdb_rating: nil).order(imdb_rating: :desc).limit(10)
    @featured_tv_shows = TvShow.includes(:genre).limit(6)
    @latest_tv_shows = TvShow.includes(:genre).order(created_at: :desc).limit(10)
    @genres = Genre.all
  end
end
