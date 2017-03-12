class Event < ApplicationRecord
  belongs_to :device
  after_create :mark_as_newest

  def time
    created_at.in_time_zone.strftime('%I:%M %P')
  end

  def date
    created_at.in_time_zone.strftime('%m/%d/%Y')
  end

  def mark_as_newest
    return unless device && (device.latest_event.nil? || created_at > device.latest_event.created_at)
    device.update_attribute(:latest_event_id, id)
  end

  def pretty_label
    return label unless (defined? device.class::POSSIBLE_EVENTS)
    return label unless label.match?(/^:/)
    pretty_label = device.class::POSSIBLE_EVENTS[label[1..-1].to_sym] % device.name.humanize
    pretty_label || label
  end

  def simple_label
    return label unless device.class::POSSIBLE_EVENTS
    return label unless label.match?(/^:/)
    device.class::POSSIBLE_EVENTS[label[1..-1].to_sym].gsub('%s', '').strip
  end

end
