class Admin::GenresController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin_role
  layout 'admin'
  before_action :set_genre, only: [:show, :edit, :update, :destroy]
  
  def index
    @genres = Genre.includes(:movies, :tv_shows).all.page(params[:page])
  end

  def show
  end

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)

    respond_to do |format|
      if @genre.save
        format.html { redirect_to admin_genres_path, notice: 'Genre was successfully created.' }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream
      end
    end
  end

  def update
    respond_to do |format|
      if @genre.update(genre_params)
        format.html { redirect_to admin_genres_path, notice: 'Genre was successfully updated.' }
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream
      end
    end
  end

  def destroy
    @genre.destroy
    respond_to do |format|
      format.html { redirect_to admin_genres_url, notice: 'Genre was successfully destroyed.' }
      format.turbo_stream { head :ok }
    end
  end

  private

  def set_genre
    @genre = Genre.friendly.find(params[:id])
  end

  def genre_params
    params.require(:genre).permit(:name, :description)
  end

  def check_admin_role
    unless current_user&.admin?
      redirect_to root_path, alert: 'Access denied.'
    end
  end
end