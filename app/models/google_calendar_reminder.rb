class GoogleCalendarReminder < ApplicationRecord
  belongs_to :google_calendar

  scope :ready, -> { where(announced: false).where('remind_at < NOW()') }
  scope :upcoming, -> { where('remind_at > NOW()') }

  def announce
    return if announced?
    SpeechEngine.say(content, volume: 100)
    update_attribute :announced, true
  end
end
