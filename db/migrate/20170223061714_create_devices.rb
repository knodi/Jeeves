class CreateDevices < ActiveRecord::Migration[5.0]
  def change
    create_table :devices do |t|
      t.string :name
      t.string :type
      t.integer :room_id
      t.integer :latest_event_id

      t.timestamps
    end
  end
end
