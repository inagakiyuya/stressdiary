class SympathiesController < ApplicationController
  def create
    diary = Diary.find(params[:diary_id])
    current_user.sympathy(diary)
    redirect_to diaries_path, success: "日記に共感しました"
  end

  def destroy
    diary = Diary.find(params[:diary_id])
    current_user.unsympathy(diary)
    redirect_to diaries_path, success: "日記に共感できませんでした"
  end
end
