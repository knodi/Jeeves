class Smartphone < Device
  def at_home?
    events.first.try(:label) == ':at_home'
  end

  # colin phone - a0:8d:16:f3:83:1d
  # ellen phone - 40:40:a7:3d:08:14
  def self.poll_all
    # on pi:
    # arp-scan --interface=wlan0 --localnet

    # on mac:
    #

    # tplink password B33BA9F0 
    # public IP 70.115.132.177
  end
end
