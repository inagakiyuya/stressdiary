class AddCategoryToMeans < ActiveRecord::Migration[7.0]
  def change
    add_column :means, :category, :string
  end
end
