class CreateMeans < ActiveRecord::Migration[7.0]
  def change
    create_table :means do |t|
      t.string :title
      t.text :situation
      t.text :approach
      t.text :result
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
