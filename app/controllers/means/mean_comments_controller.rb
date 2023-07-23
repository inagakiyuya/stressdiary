class Means::MeanCommentsController < ApplicationController
  before_action :require_login

  def create
    @mean_comment = current_user.mean_comments.new(mean_comment_params)
    if @mean_comment.save
      redirect_to mean_path(@mean_comment.mean_id), success: "コメントを作成しました"
    else
      @mean = @mean_comment.mean
      flash.now[:danger] = "コメントを作成できませんでした"
      render 'means/show'
    end
  end

  def update
    @mean_comment = current_user.mean_comments.find(params[:id])
    @mean_comment.update!(mean_comment_params)

    redirect_to mean_path(@mean_comment.mean_id), success: "コメントを更新しました"
  end

  def destroy
    @mean = Mean.find(params[:mean_id])
    @mean_comment = current_user.mean_comments.find(params[:id])
    @mean_comment.destroy!

    redirect_to mean_path(@mean), success: "コメントを削除しました"
  end

  private

  def mean_comment_params
    params.require(:mean_comment).permit(:body).merge(mean_id: params[:mean_id])
  end
end
