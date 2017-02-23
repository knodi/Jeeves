class Device < ApplicationRecord
  attr_accessible :current_state, :name, :room_id, :type
  has_many :events
  belongs_to :room
  
  has_one :current_state, class_name: 'Event'
end
