Warden::Strategies.add(:ip_address) do
  #VERA_IP = '::1'
  VERA_IP = '10.0.2.3'

  def valid?
    Rails.logger.info "Warden checking strategy ip_address against #{request.ip}"
    request.ip == VERA_IP
  end

  def authenticate!
    if request.ip == VERA_IP
      u = User.find_by(username: 'vera')
      u ? success!(u) : fail!
    end
  end
end
