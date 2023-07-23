class FavoritesController < ApplicationController
  def create
    diary = Diary.find(params[:diary_id])
    current_user.favorite(diary)
    redirect_to diaries_path, success: "お気に入りに登録しました"
  end

  def destroy
    diary = Diary.find(params[:diary_id])
    current_user.unfavorite(diary)
    redirect_to diaries_path, success: "お気に入りから外しました"
  end
end
