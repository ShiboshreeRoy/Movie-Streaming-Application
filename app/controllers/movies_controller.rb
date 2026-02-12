class MoviesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    @movies = Movie.includes(:genre).order(created_at: :desc)
    
    # Apply filters
    if params[:genre_id].present?
      @movies = @movies.by_genre(params[:genre_id])
    end
    
    if params[:year].present?
      @movies = @movies.by_year(params[:year])
    end
    
    if params[:min_rating].present?
      @movies = @movies.by_rating(params[:min_rating])
    end
    
    if params[:search].present?
      @movies = @movies.where("title ILIKE ?", "%#{params[:search]}%")
    end
    
    @movies = @movies.page(params[:page]).per(20)
    @genres = Genre.all
  end

  def show
    @movie = Movie.includes(:genre, :ads).friendly.find(params[:id])
    @related_movies = Movie.where(genre_id: @movie.genre_id).where.not(id: @movie.id).limit(12)
    @average_rating = @movie.user_movie_ratings.average(:rating)&.round(1)
    @user_rating = current_user&.user_movie_ratings&.find_by(movie: @movie)&.rating if user_signed_in?
    
    # Handle watch parameter for streaming
    if params[:watch] == 'true'
      if @movie.display_video_url
        # Could redirect to a dedicated player page or modal
        # For now, we'll just highlight the streaming option
      end
    end
    
    # Get active ads for this movie
    @pre_roll_ads = @movie.ads.where(position: 'pre').where(active: true)
    @mid_roll_ads = @movie.ads.where(position: 'mid').where(active: true)
    @post_roll_ads = @movie.ads.where(position: 'post').where(active: true)
  end
end
