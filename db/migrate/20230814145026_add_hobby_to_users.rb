class AddHobbyToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :hobby1, :string
    add_column :users, :hobby2, :string
    add_column :users, :hobby3, :string
  end
end
