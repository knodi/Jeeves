class CreateGoogleCalendars < ActiveRecord::Migration[5.0]
  def change
    create_table :google_calendars do |t|
      t.string :name
      t.string :google_id
      t.boolean :active
      t.boolean :verbalize
      t.datetime :last_updated
      t.integer :last_update_status
      t.timestamps
    end
  end
end
