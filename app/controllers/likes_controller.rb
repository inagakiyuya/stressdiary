class LikesController < ApplicationController
  def create
    mean = Mean.find(params[:mean_id])
    current_user.like(mean)
    redirect_to means_path, success: "liked post."
  end

  def destroy
    mean = Mean.find(params[:mean_id])
    current_user.unlike(mean)
    redirect_to means_path, success: "unliked post."
  end
end
