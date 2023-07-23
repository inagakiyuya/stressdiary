class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: %i[show destroy]

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(10)
  end

  def show; end

  def destroy
    @user.destroy!
    redirect_to admin_users_path, success: "ログアウトしました。"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :role)
  end
end
