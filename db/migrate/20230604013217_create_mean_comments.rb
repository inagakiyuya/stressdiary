class CreateMeanComments < ActiveRecord::Migration[7.0]
  def change
    create_table :mean_comments do |t|
      t.text :body, null: false
      t.references :user, null: false, foreign_key: true
      t.references :mean, null: false, foreign_key: true

      t.timestamps
    end
  end
end
