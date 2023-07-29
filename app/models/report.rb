class Report < ApplicationRecord
  belongs_to :reporter, class_name: "User"
  belongs_to :reported, class_name: "User"

  def self.reported_count(user_id)
    where(reported_id: user_id).count
  end
end
