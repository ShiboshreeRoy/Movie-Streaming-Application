class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user = current_user
    @favorite_movies = @user.user_favorites.includes(movie: :genre).map(&:movie)
    @rated_movies = @user.user_movie_ratings.includes(movie: :genre).map(&:movie)
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Profile updated successfully.'
    else
      render :edit
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:email, :first_name, :last_name)
  end
end
