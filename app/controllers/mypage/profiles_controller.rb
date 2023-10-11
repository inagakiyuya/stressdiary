class Mypage::ProfilesController < Mypage::BaseController
  def show
    @user = current_user
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(profile_params)
      redirect_to mypage_profile_path, success: 'プロフィールを更新しました'
    else
      render :show
    end
  end

  def view_users
    @user = User.find(params[:id])
  end

  def mymean
    @means = current_user.means.includes(:user).order(created_at: :desc).page(params[:page]).per(10)
  end

  def bookmarks
    bookmarks = Bookmark.where(user_id: current_user.id).pluck(:mean_id)
    @bookmark_means = Mean.find(bookmarks)
  end

  def mydiary
    @diaries = current_user.diaries.includes(:user, :stress_diagnosis, :happy_diagnosis).order(created_at: :desc).page(params[:page]).per(10)
  end

  def favorites
    favorites = Favorite.where(user_id: current_user.id).pluck(:diary_id)
    @favorite_diaries = Diary.find(favorites)
  end

  def stress_chart
    @stress_datas = current_user.diaries.past_stress_diagnosis_datas            
  end

  def happy_chart
    @happy_datas = current_user.diaries.past_happy_diagnosis_datas
  end

  def like_ranking
    User.all.each(&:update_total_like_counts)
    @user_like_ranks = User.all.order(total_like_counts: :desc).limit(10)
  end

  def like_ranking_in_past_month
    User.all.each(&:update_total_like_counts_in_past_month)
    @user_like_ranks_in_past_month = User.all.order(total_like_counts_in_past_month: :desc).limit(10)
  end

  def like_ranking_in_past_week
    User.all.each(&:update_total_like_counts_in_past_week)
    @user_like_ranks_in_past_week = User.all.order(total_like_counts_in_past_week: :desc).limit(10)
  end

  def sympathy_ranking
    User.all.each(&:update_total_sympathy_counts)
    @user_sympathy_ranks = User.all.order(total_sympathy_counts: :desc).limit(10)
  end

  def sympathy_ranking_in_past_month
    User.all.each(&:update_total_sympathy_counts_in_past_month)
    @user_sympathy_ranks_in_past_month = User.all.order(total_sympathy_counts_in_past_month: :desc).limit(10)
  end

  def sympathy_ranking_in_past_week
    User.all.each(&:update_total_sympathy_counts_in_past_week)
    @user_sympathy_ranks_in_past_week = User.all.order(total_sympathy_counts_in_past_week: :desc).limit(10)
  end

  def show_recommended_means
    @recommended_means = current_user.get_recommended_means
  end

  private

  def profile_params
    params.require(:user).permit(:name, :email, :password, :avatar, :hobby1, :hobby2, :hobby3,
                                 :total_sympathy_counts, :total_sympathy_counts_in_past_month, :total_sympathy_counts_in_past_week,
                                 :total_like_counts, :total_like_counts_in_past_month, :total_like_counts_in_past_week)
  end
end
