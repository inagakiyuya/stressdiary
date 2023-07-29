class Admin::BaseController < ApplicationController
  before_action :check_admin
  layout 'admin/layouts/application'

  private

  def not_authenticated
    redirect_to admin_login_path, warning: "ログインをしてください。"
  end

  def check_admin
    redirect_to root_path, warning: "管理権限がありません。" unless current_user.admin?
  end
end
