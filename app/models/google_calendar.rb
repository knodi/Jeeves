class GoogleCalendar < ApplicationRecord
  has_many :reminders, class_name: 'GoogleCalendarReminder'

  enum last_update_status: {
    success: 1,
    error: -1,
  }
  scope :active, -> { where(active: true) }
  scope :needs_refresh, -> { active.where('last_updated < ?', 90.minutes.ago) }

  def self.cron_process
    needs_refresh.each(&:refresh!)

    active.each do |calendar|
      calendar.reminders.ready.map(&:announce)
    end
  end

  def refresh!
    return unless active?

    events = GoogleCalendarApi.list_events(google_id)
    events.each do |event|
      reminder = reminders.find_or_initialize_by(google_id: event.id)
      reminder.remind_at = event.start.date_time
      reminder.content = event.summary
      reminder.save
    end
    # if any upcoming events wasn't in the list, it must have been deleted
    reminders.upcoming.where.not(google_id: events.map(&:id)).delete_all

    self.last_update_status = :success
  rescue
    self.last_update_status = :error
  ensure
    self.last_updated = Time.now
    save
  end

end
