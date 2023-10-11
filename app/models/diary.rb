class Diary < ApplicationRecord
  searchkick text_middle: [:title]

  belongs_to :user
  has_many :diary_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :sympathies, dependent: :destroy
  has_one :stress_diagnosis, dependent: :destroy
  has_one :happy_diagnosis, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
  validates :stress, presence: true, length: { maximum: 65_535 }
  validates :happy, presence: true, length: { maximum: 65_535 }
  validates :goal, presence: true, length: { maximum: 65_535 }

  def self.past_stress_diagnosis_datas
    includes(:stress_diagnosis)
      .joins(:stress_diagnosis)
      .where('diaries.created_at >= ?', 31.days.ago)
      .where('stress_diagnoses.stress_count >= ?', 0)
      .select("date(diaries.created_at) as date, stress_diagnoses.stress_count")
      .order("date ASC")
      .group_by { |d| d.date }
      .map { |date, rows| [date.to_s, rows.sum(&:stress_count)] }
  end

  def self.past_happy_diagnosis_datas
    includes(:happy_diagnosis)
      .joins(:happy_diagnosis)
      .where('diaries.created_at >= ?', 31.days.ago)
      .where('happy_diagnoses.happy_count >= ?', 0)
      .select("date(diaries.created_at) as date, happy_diagnoses.happy_count")
      .order("date ASC")
      .group_by { |d| d.date }
      .map { |date, rows| [date.to_s, rows.sum(&:happy_count)] }
  end
end
