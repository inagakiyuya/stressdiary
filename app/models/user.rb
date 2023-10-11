class User < ApplicationRecord
  authenticates_with_sorcery!
  searchkick text_middle: [:name]

  has_many :means, dependent: :destroy
  has_many :mean_comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_means, through: :bookmarks, source: :mean
  has_many :likes, dependent: :destroy
  has_many :liked_means, through: :likes, source: :mean

  has_many :diaries, dependent: :destroy
  has_many :diary_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_diaries, through: :favorites, source: :diary
  has_many :sympathies, dependent: :destroy
  has_many :sympathy_diaries, through: :sympathies, source: :diary

  has_many :reporter, class_name: "Report", foreign_key: "reporter_id", dependent: :destroy
  has_many :reported, class_name: "Report", foreign_key: "reported_id", dependent: :destroy

  has_one_attached :avatar

  enum role: { general: 0, admin: 1 }

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :reset_password_token, presence: true, uniqueness: true, allow_nil: true

  validates :email, uniqueness: true
  validates :email, presence: true
  validates :name, presence: true, length: { maximum: 255 }

  def mine?(object)
    object.user_id == id
  end

  def bookmark(mean)
    bookmark_means << mean
  end

  def unbookmark(mean)
    bookmark_means.destroy(mean)
  end

  def bookmark?(mean)
    bookmark_means.include?(mean)
  end

  def like(mean)
    liked_means << mean
  end

  def unlike(mean)
    liked_means.destroy(mean)
  end

  def like?(mean)
    liked_means.include?(mean)
  end

  def total_likes
    user_total_like_counts = 0
    self.means.each do |mean|
      user_total_like_counts += mean.likes.where(mean_id: mean.id).count
    end
    user_total_like_counts
  end

  def update_total_like_counts
    self.total_like_counts = total_likes
    save
  end

  def total_likes_in_past_month
    user_total_like_counts_in_past_month = 0
    self.means.each do |mean|
      user_total_like_counts_in_past_month += mean.likes.where(mean_id: mean.id, created_at: (1.month.ago..Time.now)).count
    end
    user_total_like_counts_in_past_month
  end

  def update_total_like_counts_in_past_month
    self.total_like_counts_in_past_month = total_likes_in_past_month
    save
  end

  def total_likes_in_past_week
    user_total_like_counts_in_past_week = 0
    self.means.each do |mean|
      user_total_like_counts_in_past_week += mean.likes.where(mean_id: mean.id, created_at: (1.week.ago..Time.now)).count
    end
    user_total_like_counts_in_past_week
  end

  def update_total_like_counts_in_past_week
    self.total_like_counts_in_past_week = total_likes_in_past_week
    save
  end

  def favorite(diary)
    favorite_diaries << diary
  end

  def unfavorite(diary)
    favorite_diaries.destroy(diary)
  end

  def favorite?(diary)
    favorite_diaries.include?(diary)
  end

  def sympathy(diary)
    sympathy_diaries << diary
  end

  def unsympathy(diary)
    sympathy_diaries.destroy(diary)
  end

  def sympathy?(diary)
    sympathy_diaries.include?(diary)
  end

  def total_sympathies
    user_total_sympathy_counts = 0
    self.diaries.each do |diary|
      user_total_sympathy_counts += diary.sympathies.where(diary_id: diary.id).count
    end
    user_total_sympathy_counts
  end

  def update_total_sympathy_counts
    self.total_sympathy_counts = total_sympathies
    save
  end

  def total_sympathies_in_past_month
    user_total_sympathy_counts_in_past_month = 0
    self.diaries.each do |diary|
      user_total_sympathy_counts_in_past_month += diary.sympathies.where(diary_id: diary.id, created_at: (1.month.ago..Time.now)).count
    end
    user_total_sympathy_counts_in_past_month
  end

  def update_total_sympathy_counts_in_past_month
    self.total_sympathy_counts_in_past_month = total_sympathies_in_past_month
    save
  end

  def total_sympathies_in_past_week
    user_total_sympathy_counts_in_past_week = 0
    self.diaries.each do |diary|
      user_total_sympathy_counts_in_past_week += diary.sympathies.where(diary_id: diary.id, created_at: (1.week.ago..Time.now)).count
    end
    user_total_sympathy_counts_in_past_week
  end

  def update_total_sympathy_counts_in_past_week
    self.total_sympathy_counts_in_past_week = total_sympathies_in_past_week
    save
  end

  def get_recommended_means
    hobbies = [hobby1, hobby2, hobby3].compact
    recommended_means = []

    if hobbies.present?
      seen_categories = []

      hobbies.each do |hobby|
        mean = Mean.where(category: hobby)
                   .where.not(user_id: id)
                   .order(Arel.sql('RANDOM()'))
                   .first
        if mean.present? && !seen_categories.include?(mean.category)
         recommended_means << mean
         seen_categories << mean.category
        end
      end
    end

    recommended_means
  end
end
