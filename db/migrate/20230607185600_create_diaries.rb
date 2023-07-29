class CreateDiaries < ActiveRecord::Migration[7.0]
  def change
    create_table :diaries do |t|
      t.string :title
      t.text :stress
      t.text :happy
      t.text :goal
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
