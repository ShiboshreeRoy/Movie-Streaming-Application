class Admin::AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin_role
  layout 'admin'

  def index
    redirect_to admin_root_path
  end
  
  def dashboard
    # Dashboard action - renders the dashboard view
    render template: 'admin/dashboard'
  end

  private

  def check_admin_role
    unless current_user&.admin?
      redirect_to root_path, alert: 'Access denied.'
    end
  end
end