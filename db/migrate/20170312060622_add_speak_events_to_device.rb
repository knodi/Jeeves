class AddSpeakEventsToDevice < ActiveRecord::Migration[5.0]
  def change
    add_column :devices, :speak_events, :boolean, default: true
  end
end
