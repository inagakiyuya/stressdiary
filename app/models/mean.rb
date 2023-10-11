class Mean < ApplicationRecord
  searchkick text_middle: [:title, :approach, :category], merge_mappings: true

  belongs_to :user
  has_many :mean_comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
  validates :situation, presence: true, length: { maximum: 65_535 }
  validates :approach, presence: true, length: { maximum: 65_535 }
  validates :result, presence: true, length: { maximum: 65_535 }
  validates :category, presence: true
end
