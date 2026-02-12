class TvShowsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    @tv_shows = TvShow.includes(:genre).order(created_at: :desc)
    
    # Apply filters
    if params[:genre_id].present?
      @tv_shows = @tv_shows.by_genre(params[:genre_id])
    end
    
    if params[:year].present?
      @tv_shows = @tv_shows.by_year(params[:year])
    end
    
    if params[:min_rating].present?
      @tv_shows = @tv_shows.by_rating(params[:min_rating])
    end
    
    if params[:search].present?
      @tv_shows = @tv_shows.where("title ILIKE ?", "%#{params[:search]}%")
    end
    
    @tv_shows = @tv_shows.page(params[:page]).per(20)
    @genres = Genre.all
  end

  def show
    @tv_show = TvShow.includes(:genre, :ads).friendly.find(params[:id])
    @related_tv_shows = TvShow.where(genre_id: @tv_show.genre_id).where.not(id: @tv_show.id).limit(6)
    
    # Get active ads for this TV show if watching
    if params[:watch] == 'true'
      @pre_roll_ads = @tv_show.ads.where(position: 'pre').where(active: true)
      @mid_roll_ads = @tv_show.ads.where(position: 'mid').where(active: true)
      @post_roll_ads = @tv_show.ads.where(position: 'post').where(active: true)
    end
  end
  
  def download
    @tv_show = TvShow.friendly.find(params[:id])
    
    # Check if download is enabled
    unless @tv_show.enable_download
      redirect_back fallback_location: @tv_show, alert: 'Download not available for this TV show.'
      return
    end
    
    # Authenticate user
    authenticate_user!
    
    # Check if user has paid for download (if priced)
    if @tv_show.download_price && @tv_show.download_price > 0
      # Here you would implement payment logic
      # For now, we'll just check if user is authenticated
      redirect_back fallback_location: @tv_show, alert: 'Payment required for this download.' and return
    end
    
    # Serve the video file for download
    if @tv_show.video.attached?
      redirect_to rails_blob_path(@tv_show.video, disposition: 'attachment')
    else
      redirect_back fallback_location: @tv_show, alert: 'No video file available for download.'
    end
  end
end
