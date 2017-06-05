Warden::Strategies.add(:ip_address) do
  #VERA_IP = '::1'
  VERA_IP = '10.0.1.46'
  INTERNAL_IP = '10.0.1.'

  def valid?
    Rails.logger.info "Warden checking strategy ip_address against #{request.ip}"

    request.ip == VERA_IP
    #request.ip[0..(INTERNAL_IP.length-1)] == INTERNAL_IP
  end

  def authenticate!
    if request.ip == VERA_IP
      u = User.find_by(username: 'vera')
      u ? success!(u) : fail!
    end
  end
end
