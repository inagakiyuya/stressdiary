class AddFourCountColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :total_sympathy_counts_in_past_month, :integer, default: 0, null: false
    add_column :users, :total_sympathy_counts_in_past_week, :integer, default: 0, null: false
    add_column :users, :total_like_counts_in_past_month, :integer, default: 0, null: false
    add_column :users, :total_like_counts_in_past_week, :integer, default: 0, null: false
  end
end
