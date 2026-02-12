class Admin::AdsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin_role
  layout 'admin'
  before_action :set_ad, only: [:show, :edit, :update, :destroy]
  
  def index
    @ads = Ad.all.page(params[:page])
  end

  def show
  end

  def new
    @ad = Ad.new
  end

  def create
    @ad = Ad.new(ad_params)

    respond_to do |format|
      if @ad.save
        format.html { redirect_to admin_ads_path, notice: 'Ad was successfully created.' }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream
      end
    end
  end

  def update
    respond_to do |format|
      if @ad.update(ad_params)
        format.html { redirect_to admin_ads_path, notice: 'Ad was successfully updated.' }
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream
      end
    end
  end

  def destroy
    @ad.destroy
    respond_to do |format|
      format.html { redirect_to admin_ads_url, notice: 'Ad was successfully destroyed.' }
      format.turbo_stream { head :ok }
    end
  end

  private

  def set_ad
    @ad = Ad.find(params[:id])
  end

  def ad_params
    params.require(:ad).permit(:title, :url, :duration, :position, :script, :active, :placement_zone, :priority, :movie_id)
  end

  def check_admin_role
    unless current_user&.admin?
      redirect_to root_path, alert: 'Access denied.'
    end
  end
end