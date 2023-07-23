class MeansController < ApplicationController
  before_action :require_login, only: %i[new create]

  def index
    @means = @m.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page]).per(10)
  end

  def new
    @mean = Mean.new
  end

  def create
    @mean = current_user.means.new(mean_params)
    if @mean.save
      redirect_to mean_path(@mean), success: 'ストレス解消法を作成しました'
    else
      flash.now[:danger] = 'ストレス解消法を作成できませんでした'
      render :new
    end
  end

  def show
    @mean = Mean.find(params[:id])
    @mean_comment = MeanComment.new
    @mean_comments = @mean.mean_comments.includes(:user).order(created_at: :desc)
  end

  def edit
    @mean = current_user.means.find(params[:id])
  end

  def update
    @mean = current_user.means.find(params[:id])
    if @mean.update(mean_params)
      redirect_to mean_path(@mean), success: 'ストレス解消法を更新しました'
    else
      flash.now[:danger] = 'ストレス解消法を更新できませんでした'
      render :edit
    end
  end

  def destroy
    @mean = current_user.means.find(params[:id])
    @mean.destroy!
    redirect_to means_path, success: 'ストレス解消法を削除しました'
  end

  private

  def mean_params
    params.require(:mean).permit(:title, :situation, :approach, :result)
  end
end
