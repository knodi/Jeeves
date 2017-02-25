class Event < ApplicationRecord
  belongs_to :device
  
  after_create :mark_as_newest
  
  def mark_as_newest
    if self.device && (self.device.latest_event.nil? || self.created_at > self.device.latest_event.created_at)
      self.device.update_attribute(:latest_event_id, self.id) 
    end
  end
end
