class DiariesController < ApplicationController
  before_action :require_login, only: %i[new create]

  def index
    @diaries = @d.result(distinct: true).includes(:user, :stress_diagnosis, :happy_diagnosis).order(created_at: :desc).page(params[:page]).per(10)
  end

  def new
    @diary = Diary.new
  end

  def create
    @diary = current_user.diaries.new(diary_params)
    if @diary.save
      redirect_to new_diary_stress_diagnosis_path(@diary), success: '日記を作成しました'
    else
      flash.now[:danger] = '日記を作成できませんでした'
      render :new
    end
  end

  def show
    @diary = Diary.find(params[:id])
    @diary_comment = DiaryComment.new
    @diary_comments = @diary.diary_comments.includes(:user).order(created_at: :desc)
  end

  def destroy
    @diary = current_user.diaries.find(params[:id])
    @diary.destroy!
    redirect_to diaries_path, success: '日記を削除しました'
  end

  private

  def diary_params
    params.require(:diary).permit(:title, :stress, :happy, :goal)
  end
end
