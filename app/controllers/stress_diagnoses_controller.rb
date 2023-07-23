class StressDiagnosesController < ApplicationController
  def new
    @diary = Diary.find(params[:diary_id])
    @stress_diagnosis = StressDiagnosis.new
    @stress_diagnosis.diary = @diary
  end

  def create
    @diary = current_user.diaries.find(params[:diary_id])
    @stress_diagnosis = StressDiagnosis.new(stress_diagnosis_params)
    @stress_diagnosis.diary = @diary

    if @stress_diagnosis.calculate_stress_count && @stress_diagnosis.save
      redirect_to new_diary_happy_diagnosis_path(@diary), success: 'ストレス診断を作成しました'
    else
      flash.now[:danger] = 'ストレス診断を作成できませんでした'
      render :new
    end
  end

  private

  def stress_diagnosis_params
    params.require(:stress_diagnosis).permit(:stress_count, :answer1, :answer2, :answer3, :answer4, :answer5,
                                                            :answer6, :answer7, :answer8, :answer9, :answer10,
                                                            :answer11, :answer12, :answer13, :answer14, :answer15,
                                                            :answer16, :answer17, :answer18, :answer19, :answer20,
                                                            :answer21, :answer22, :answer23, :answer24, :answer25,)
  end
end
