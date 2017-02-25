class Device < ApplicationRecord
  has_many :events
  belongs_to :room
    
  belongs_to :latest_event, class_name: Event
end
