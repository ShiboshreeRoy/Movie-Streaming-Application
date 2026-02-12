class Admin::TvShowsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin_role
  layout 'admin'
  before_action :set_tv_show, only: [:show, :edit, :update, :destroy]
  
  def index
    @tv_shows = TvShow.includes(:genre, :user).all.page(params[:page])
  end

  def show
  end

  def new
    @tv_show = TvShow.new
    @genres = Genre.all
  end

  def edit
    @genres = Genre.all
  end

  def create
    @tv_show = TvShow.new(tv_show_params)
    @tv_show.user = current_user

    respond_to do |format|
      if @tv_show.save
        format.html { redirect_to admin_tv_show_path(@tv_show), notice: 'TV Show was successfully created.' }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream
      end
    end
  end

  def update
    respond_to do |format|
      if @tv_show.update(tv_show_params)
        format.html { redirect_to admin_tv_show_path(@tv_show), notice: 'TV Show was successfully updated.' }
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream
      end
    end
  end

  def destroy
    @tv_show.destroy
    respond_to do |format|
      format.html { redirect_to admin_tv_shows_url, notice: 'TV Show was successfully destroyed.' }
      format.turbo_stream { head :ok }
    end
  end

  private

  def set_tv_show
    @tv_show = TvShow.friendly.find(params[:id])
  end

  def tv_show_params
    params.require(:tv_show).permit(
      :title, :genre_id, :release_year, :seasons, :episodes, :imdb_rating, 
      :country, :creator, :cast, :description, :thumbnail, :poster_url, 
      :trailer_url, :enable_ads, :ad_frequency, :enable_download, 
      :download_quality, :download_price
    )
  end

  def check_admin_role
    unless current_user&.admin?
      redirect_to root_path, alert: 'Access denied.'
    end
  end
end