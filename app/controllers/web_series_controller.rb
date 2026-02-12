class WebSeriesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    @web_series = WebSeries.includes(:genre).recent
    
    # Apply filters
    if params[:genre_id].present?
      @web_series = @web_series.by_genre(params[:genre_id])
    end
    
    if params[:season].present?
      @web_series = @web_series.by_season(params[:season])
    end
    
    if params[:search].present?
      @web_series = @web_series.where("title ILIKE ?", "%#{params[:search]}%")
    end
    
    @web_series = @web_series.page(params[:page]).per(20)
    @genres = Genre.all
  end

  def show
    @web_series = WebSeries.includes(:genre, :ads).friendly.find(params[:id])
    @related_series = WebSeries.where(genre_id: @web_series.genre_id)
                              .where.not(id: @web_series.id)
                              .limit(12)
    
    # Increment view count (only once per session)
    unless session[:viewed_web_series]&.include?(@web_series.id)
      @web_series.increment_views!
      session[:viewed_web_series] ||= []
      session[:viewed_web_series] << @web_series.id
    end
    
    # Get active ads for this web series if watching
    if params[:watch]
      @pre_roll_ads = @web_series.ads.where(position: 'pre').where(active: true)
      @mid_roll_ads = @web_series.ads.where(position: 'mid').where(active: true)
      @post_roll_ads = @web_series.ads.where(position: 'post').where(active: true)
    end
  end
  
  def download
    @web_series = WebSeries.friendly.find(params[:id])
    
    # Check if download is enabled
    unless @web_series.enable_download
      redirect_back fallback_location: @web_series, alert: 'Download not available for this episode.'
      return
    end
    
    # Authenticate user
    authenticate_user!
    
    # Check if user has paid for download (if priced)
    if @web_series.download_price && @web_series.download_price > 0
      # Here you would implement payment logic
      # For now, we'll just check if user is authenticated
      redirect_back fallback_location: @web_series, alert: 'Payment required for this download.' and return
    end
    
    # Increment download count (only once per session)
    unless session[:downloaded_web_series]&.include?(@web_series.id)
      @web_series.increment_downloads!
      session[:downloaded_web_series] ||= []
      session[:downloaded_web_series] << @web_series.id
    end
    
    # Serve the video file for download
    if @web_series.video.attached?
      redirect_to rails_blob_path(@web_series.video, disposition: 'attachment')
    else
      redirect_back fallback_location: @web_series, alert: 'No video file available for download.'
    end
  end
end