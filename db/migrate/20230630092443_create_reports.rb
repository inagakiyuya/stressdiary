class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.text :reason, null: false

      t.references :reporter, foreign_key: { to_table: :users }, null: false
      t.references :reported, foreign_key: { to_table: :users }, null: false

      t.timestamps
    end
  end
end
