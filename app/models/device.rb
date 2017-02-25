class Device < ApplicationRecord
  has_many :events
  belongs_to :room
    
  has_one :current_state, class_name: 'Event'
end
