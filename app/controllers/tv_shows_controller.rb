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
    @tv_show = TvShow.includes(:genre).friendly.find(params[:id])
    @related_tv_shows = TvShow.where(genre_id: @tv_show.genre_id).where.not(id: @tv_show.id).limit(6)
  end
end
