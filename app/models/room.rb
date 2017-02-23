class Room < ApplicationRecord
  attr_accessible :floor, :name
  
  has_many :devices
end
