class Diary < ApplicationRecord
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

  private

  def self.ransackable_attributes(auth_object = nil)
    ["title", "created_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end
end
