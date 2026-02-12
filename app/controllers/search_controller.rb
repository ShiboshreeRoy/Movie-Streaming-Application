class SearchController < ApplicationController
  def search
    @search_term = params[:q]
    @movies = Movie.none
    @tv_shows = TvShow.none
    
    if @search_term.present?
      @movies = Movie.where("title ILIKE ? OR description ILIKE ?", "%#{@search_term}%", "%#{@search_term}%").includes(:genre).page(params[:page]).per(20)
      @tv_shows = TvShow.where("title ILIKE ? OR description ILIKE ?", "%#{@search_term}%", "%#{@search_term}%").includes(:genre).page(params[:page]).per(20)
    end
    
    @genres = Genre.all
    
    respond_to do |format|
      format.html
      format.json { render json: { movies: @movies, tv_shows: @tv_shows } }
    end
  end
end
