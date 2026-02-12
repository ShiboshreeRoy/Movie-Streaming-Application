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
    
    # Increment view count (only once per session)
    unless session[:viewed_movies]&.include?(@movie.id)
      @movie.increment_views!
      session[:viewed_movies] ||= []
      session[:viewed_movies] << @movie.id
    end
    
    # Handle watch parameter for streaming
    if params[:watch] == 'true'
      if @movie.display_video_url
        # For now, we'll just highlight the streaming option
      end
    end
    
    # Get active ads for this movie if watching
    if params[:watch] == 'true'
      @pre_roll_ads = @movie.ads.where(position: 'pre').where(active: true)
      @mid_roll_ads = @movie.ads.where(position: 'mid').where(active: true)
      @post_roll_ads = @movie.ads.where(position: 'post').where(active: true)
    else
      # Get active ads for this movie (non-streaming view)
      @pre_roll_ads = @movie.ads.where(position: 'pre').where(active: true)
      @mid_roll_ads = @movie.ads.where(position: 'mid').where(active: true)
      @post_roll_ads = @movie.ads.where(position: 'post').where(active: true)
    end
  end
  
  def download
    @movie = Movie.friendly.find(params[:id])
    
    # Check if download is enabled
    unless @movie.enable_download
      redirect_back fallback_location: @movie, alert: 'Download not available for this movie.'
      return
    end
    
    # Authenticate user
    authenticate_user!
    
    # Check if user has paid for download (if priced)
    if @movie.download_price && @movie.download_price > 0
      # Here you would implement payment logic
      # For now, we'll just check if user is authenticated
      redirect_back fallback_location: @movie, alert: 'Payment required for this download.' and return
    end
    
    # Increment download count (only once per session)
    unless session[:downloaded_movies]&.include?(@movie.id)
      @movie.increment_downloads!
      session[:downloaded_movies] ||= []
      session[:downloaded_movies] << @movie.id
    end
    
    # Serve the video file for download
    if @movie.video.attached?
      redirect_to rails_blob_path(@movie.video, disposition: 'attachment')
    else
      redirect_back fallback_location: @movie, alert: 'No video file available for download.'
    end
  end
end
