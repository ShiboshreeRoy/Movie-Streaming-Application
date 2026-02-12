class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin_role
  layout 'admin'
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all.page(params[:page])
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_user_path(@user), notice: 'User was successfully updated.' }
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_url, notice: 'User was successfully destroyed.' }
      format.turbo_stream { head :ok }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :admin)
  end

  def check_admin_role
    unless current_user&.admin?
      redirect_to root_path, alert: 'Access denied.'
    end
  end
end