class AnnounceJob < ApplicationJob
  queue_as :default

  def perform(google_calendar_reminder_id)
    GoogleCalendarReminder.
      find(google_calendar_reminder_id).
      announce
  rescue ActiveRecord::RecordNotFound
    Rails.logger.warn("Could not announce google_calendar_reminder_id #{google_calendar_reminder_id}")
  end
end
