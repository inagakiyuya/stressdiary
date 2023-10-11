class DiariesController < ApplicationController
  before_action :require_login, only: %i[new create]

  def index
    @diaries = if params[:query].blank?
                 Diary.all.includes(:user, :stress_diagnosis, :happy_diagnosis)
                      .order(created_at: :desc).page(params[:page]).per(5)
               else
                 Diary.joins(:user)
                      .where("title LIKE ? OR users.name LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
                      .includes(:user, :stress_diagnosis, :happy_diagnosis)
                      .order(created_at: :desc).page(params[:page]).per(5)
               end
  end

  def new
    @diary = Diary.new
  end

  def create
    @today_diary = current_user.diaries.find_by(created_at: Date.today.beginning_of_day..Date.today.end_of_day)

    if @today_diary.present?
      redirect_to diaries_path, danger: '本日、日記は既に作成しました。'
    else
      @diary = current_user.diaries.new(diary_params)

      respond_to do |format|
        if @diary.save
          format.html { redirect_to new_diary_stress_diagnosis_path(@diary), success: '日記を作成しました。' }
          format.json { render :show, status: :created, location: @diary }
        else
          format.html { render :new, danger: '日記を作成できませんでした' }
          format.json { render json: @diary.errors, status: :unprocessable_entity }
        end
      end
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

    respond_to do |format|
      format.html { redirect_to diaries_path, success: '日記を削除しました' }
      format.json { head :no_content }
    end
  end

  private

  def diary_params
    params.require(:diary).permit(:title, :stress, :happy, :goal)
  end
end
