class Mypage::Profiles::AvatersController < ApplicationController
  def destroy
    current_user.avatar.purge
    redirect_back(fallback_location: root_path, success: '削除しました')
  end
end
