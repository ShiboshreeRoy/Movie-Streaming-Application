class UserMovieRatingsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @movie = Movie.find(params[:movie_id])
    @user_rating = current_user.user_movie_ratings.find_or_initialize_by(movie: @movie)
    @user_rating.rating = params[:rating]
    
    if @user_rating.save
      respond_to do |format|
        format.js { render json: { status: 'success', rating: @user_rating.rating } }
        format.html do
          redirect_back(fallback_location: @movie)
        end
      end
    else
      respond_to do |format|
        format.js { render json: { status: 'error', errors: @user_rating.errors.full_messages } }
        format.html do
          redirect_back(fallback_location: @movie, alert: 'Unable to save rating.')
        end
      end
    end
  end
end
