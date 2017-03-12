class Smartphone < Device
  POSSIBLE_EVENTS = {
    enter_car: '%s entered the car',
    exit_car: '%s left the car',
    enter_home: '%s arrived home',
    exit_home: '%s left home',
    enter_prodigy: '%s arrived at prodigy',
    exit_prodigy: '%s left prodigy',
  }.freeze

  def at_home?
    events.where(label: ':enter_home').first.created_at > events.where(label: ':exit_home').first.created_at
  rescue
    return false
  end

  # colin phone - a0:8d:16:f3:83:1d
  # ellen phone - 40:40:a7:3d:08:14
  # def self.poll_all
  #  # on pi:
  #  # arp-scan --interface=wlan0 --localnet
  #
  #  # on mac:
  #  #
  #
  #  # tplink password B33BA9F0
  #  # public IP 70.115.132.177
  # end
end
