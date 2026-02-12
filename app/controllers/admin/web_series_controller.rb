class Admin::WebSeriesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin_role
  layout 'admin'
  before_action :set_web_series, only: [:show, :edit, :update, :destroy]

  def index
    @web_series = WebSeries.includes(:genre, :user).all.page(params[:page])
  end

  def show
  end

  def new
    @web_series = WebSeries.new
    @web_series.ads.build # Build an empty ad for the form
    @genres = Genre.all
  end

  def edit
    @web_series.ads.build # Build an empty ad for the form
    @genres = Genre.all
  end

  def create
    @web_series = WebSeries.new(web_series_params)
    @web_series.user = current_user

    respond_to do |format|
      if @web_series.save
        format.html { 
          flash[:notice] = nil
          redirect_to admin_web_series_path(@web_series)
          flash[:toast] = { type: 'success', message: 'Web series episode was successfully created.' }
        }
        format.turbo_stream
      else
        @genres = Genre.all
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream
      end
    end
  end

  def update
    respond_to do |format|
      if @web_series.update(web_series_params)
        format.html { 
          flash[:notice] = nil
          redirect_to admin_web_series_path(@web_series)
          flash[:toast] = { type: 'success', message: 'Web series episode was successfully updated.' }
        }
        format.turbo_stream
      else
        @genres = Genre.all
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream
      end
    end
  end

  def destroy
    @web_series.destroy
    respond_to do |format|
      format.html { 
        flash[:notice] = nil
        redirect_to admin_web_series_index_url
        flash[:toast] = { type: 'success', message: 'Web series episode was successfully deleted.' }
      }
      format.turbo_stream { head :ok }
    end
  end

  private

  def set_web_series
    @web_series = WebSeries.friendly.find(params[:id])
  end

  def web_series_params
    params.require(:web_series).permit(
      :title, :genre_id, :season_number, :episode_number, :release_date, :duration,
      :description, :thumbnail, :video, :poster_url, :trailer_url,
      :enable_download, :download_quality, :download_price,
      ads_attributes: [:id, :title, :url, :duration, :position, :script, :active, :_destroy]
    )
  end

  def check_admin_role
    unless current_user&.admin?
      redirect_to root_path, alert: 'Access denied.'
    end
  end
end