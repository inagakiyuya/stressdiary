class Diaries::DiaryCommentsController < ApplicationController
  before_action :require_login

  def create
    @diary_comment = current_user.diary_comments.new(diary_comment_params)
    if @diary_comment.save
      redirect_to diary_path(@diary_comment.diary_id), success: "コメントを作成しました"
    else
      @diary = @diary_comment.diary
      flash.now[:danger] = "コメントを作成できませんでした"
      render 'diaries/show'
    end
  end

  def update
    @diary_comment = current_user.mean_comments.find(params[:id])
    @diary_comment.update!(diary_comment_params)

    redirect_to diary_path(@diary_comment.diary_id), success: "コメントを更新しました"
  end

  def destroy
    @diary = Diary.find(params[:diary_id])
    @diary_comment = @diary.diary_comments.find(params[:id])
    @diary_comment.destroy!

    redirect_to diary_path(@diary), success: "コメントを削除しました"
  end

  private

  def diary_comment_params
    params.require(:diary_comment).permit(:body).merge(diary_id: params[:diary_id])
  end
end
