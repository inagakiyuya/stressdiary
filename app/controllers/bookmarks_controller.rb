class BookmarksController < ApplicationController
  def create
    mean = Mean.find(params[:mean_id])
    current_user.bookmark(mean)
    redirect_to means_path, success: "ブックマークを作成しました"
  end

  def destroy
    mean = Mean.find(params[:mean_id])
    current_user.unbookmark(mean)
    redirect_to means_path, success: "ブックマークを削除しました"
  end
end
