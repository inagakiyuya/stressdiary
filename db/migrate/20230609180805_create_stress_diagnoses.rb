class CreateStressDiagnoses < ActiveRecord::Migration[7.0]
  def change
    create_table :stress_diagnoses do |t|
      t.integer :stress_count
      t.references :diary, null: false, foreign_key: true
      t.boolean :answer1
      t.boolean :answer2
      t.boolean :answer3
      t.boolean :answer4
      t.boolean :answer5
      t.boolean :answer6
      t.boolean :answer7
      t.boolean :answer8
      t.boolean :answer9
      t.boolean :answer10
      t.boolean :answer11
      t.boolean :answer12
      t.boolean :answer13
      t.boolean :answer14
      t.boolean :answer15
      t.boolean :answer16
      t.boolean :answer17
      t.boolean :answer18
      t.boolean :answer19
      t.boolean :answer20
      t.boolean :answer21
      t.boolean :answer22
      t.boolean :answer23
      t.boolean :answer24
      t.boolean :answer25

      t.timestamps
    end
  end
end
