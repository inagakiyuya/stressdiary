class CreateHappyDiagnoses < ActiveRecord::Migration[7.0]
  def change
    create_table :happy_diagnoses do |t|
      t.integer :happy_count
      t.references :diary, null: false, foreign_key: true
      t.boolean :question1
      t.boolean :question2
      t.boolean :question3
      t.boolean :question4
      t.boolean :question5
      t.boolean :question6
      t.boolean :question7
      t.boolean :question8
      t.boolean :question9
      t.boolean :question10

      t.timestamps
    end
  end
end
