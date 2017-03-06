class TripSensor < Device
  POSSIBLE_EVENTS = {
    open: '%s opened',
    close: '%s closed',
  }.freeze

  def status
    raise 'Feature does not exist on this device'
  end

  def status=(_)
    raise 'Feature does not exist on this device'
  end
end
