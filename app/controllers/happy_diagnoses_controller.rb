class HappyDiagnosesController < ApplicationController
  def new
    @diary = Diary.find(params[:diary_id])
    @happy_diagnosis = HappyDiagnosis.new
    @happy_diagnosis.diary = @diary
  end

  def create
    @diary = current_user.diaries.find(params[:diary_id])
    @happy_diagnosis = HappyDiagnosis.new(happy_diagnosis_params)
    @happy_diagnosis.diary = @diary

    if @happy_diagnosis.calculate_happy_count && @happy_diagnosis.save
      redirect_to diaries_path(@diary), success: 'ストレス診断を作成しました'
    else
      flash.now[:danger] = '幸福度診断を作成できませんでした'
      render :new
    end
  end

  private

  def happy_diagnosis_params
    params.require(:happy_diagnosis).permit(:happy_count, :question1, :question2, :question3, :question4, :question5,
                                                          :question6, :question7, :question8, :question9, :question10,)
  end
end
