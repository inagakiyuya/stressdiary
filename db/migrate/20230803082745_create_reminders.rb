class CreateReminders < ActiveRecord::Migration[7.0]
  def change
    create_table :reminders do |t|
      t.datetime :remind_time, null: false

      t.timestamps
    end
  end
end
