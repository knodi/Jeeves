class CreateGoogleCalendarReminders < ActiveRecord::Migration[5.0]
  def change
    create_table :google_calendar_reminders do |t|
      t.integer :google_calendar_id
      t.string :content
      t.string :google_id, unique: true
      t.boolean :announced, default: false
      t.datetime :remind_at
      t.timestamps
    end
  end
end
