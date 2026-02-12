class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin_role

  def index
    # Dashboard statistics
    @movies_count = Movie.count
    @tv_shows_count = TvShow.count
    @users_count = User.count
    @genres_count = Genre.count
  end

  private

  def check_admin_role
    redirect_to root_path, alert: 'Access denied' unless current_user&.admin?
  end
end