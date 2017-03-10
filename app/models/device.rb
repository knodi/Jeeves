class Device < ApplicationRecord
  has_many :events, -> { order('id DESC') }
  belongs_to :room

  belongs_to :latest_event, class_name: Event
end
