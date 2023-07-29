class Admin::DiariesController < Admin::BaseController
  before_action :set_diary, only: %i[show destroy]

  def index
    @q = Diary.ransack(params[:q])
    @diaries = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @diary_comment = DiaryComment.new
    @diary_comments = @diary.diary_comments.includes(:user).order(created_at: :desc)
  end

  def destroy
    @diary.destroy!
    redirect_to admin_diaries_path, success: "一般ユーザーの日記投稿を削除しました。"
  end

  private

  def set_diary
    @diary = Diary.find(params[:id])
  end

  def diary_params
    params.require(:diary).permit(:title, :stress, :happy, :goal)
  end
end
