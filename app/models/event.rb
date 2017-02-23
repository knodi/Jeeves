class Event < ApplicationRecord
  attr_accessible :device_id, :label, :notifier
  belongs_to :device
  
  after_create :mark_as_newest
  
  def mark_as_newest
    if self.device && (self.device.current_state.nil? || self.created_at > self.device.current_state.created_at)
      self.device.update_attribute(:latest_event_id, self.id) 
    end
  end
end
