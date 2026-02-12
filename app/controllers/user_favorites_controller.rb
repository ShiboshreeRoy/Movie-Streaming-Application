class UserFavoritesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @movie = Movie.find(params[:movie_id])
    @user_favorite = current_user.user_favorites.find_or_create_by(movie: @movie)
    
    respond_to do |format|
      format.js { render json: { status: 'success', favorite: @user_favorite } }
      format.html do
        redirect_back(fallback_location: @movie)
      end
    end
  end

  def destroy
    @user_favorite = current_user.user_favorites.find(params[:id])
    @user_favorite.destroy
    
    respond_to do |format|
      format.js { render json: { status: 'success' } }
      format.html do
        redirect_back(fallback_location: root_path)
      end
    end
  end
end
