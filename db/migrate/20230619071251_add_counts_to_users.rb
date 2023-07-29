class AddCountsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :total_sympathy_counts, :integer, default: 0, null: false
    add_column :users, :total_like_counts, :integer, default: 0, null: false
  end
end
