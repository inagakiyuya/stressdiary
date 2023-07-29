class Like < ApplicationRecord
  belongs_to :user
  belongs_to :mean

  validates :user_id, uniqueness: { scope: :mean_id }
end
