class Admin::MeansController < Admin::BaseController
  before_action :set_mean, only: %i[show destroy]

  def index
    @q = Mean.ransack(params[:q])
    @means = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @mean_comment = MeanComment.new
    @mean_comments = @mean.mean_comments.includes(:user).order(created_at: :desc)
  end

  def destroy
    @mean.destroy!
    redirect_to admin_means_path, success: "一般ユーザーのストレス解消法を削除しました。"
  end

  private

  def set_mean
    @mean = Mean.find(params[:id])
  end

  def mean_params
    params.require(:mean).permit(:title, :situation, :approach, :result)
  end
end
