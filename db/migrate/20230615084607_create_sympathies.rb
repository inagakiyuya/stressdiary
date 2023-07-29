class CreateSympathies < ActiveRecord::Migration[7.0]
  def change
    create_table :sympathies do |t|
      t.references :user, null: false, foreign_key: true
      t.references :diary, null: false, foreign_key: true

      t.timestamps
    end

    add_index :sympathies, [:user_id, :diary_id], unique: true
  end
end
