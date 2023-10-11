require 'line/bot'

class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :require_login

  helper_method :current_user

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def not_authenticated
    redirect_to login_path, warning: 'Please login first.'
  end
end
