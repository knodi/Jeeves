class Smartphone < Device
  def at_home?
    events.first.try(:label) == ':at_home'
  end
end
