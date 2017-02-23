class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :label
      t.integer :device_id, :null => false
      t.boolean :notified, :default => false

      t.timestamps
    end
  end
end
