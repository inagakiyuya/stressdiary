class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :require_login, :set_mean, :set_diary

  helper_method :current_user

  private

  def set_mean
    @m = Mean.ransack(params[:q])
  end

  def set_diary
    @d = Diary.ransack(params[:q])
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def not_authenticated
    redirect_to login_path, warning: 'Please login first.'
  end
end
