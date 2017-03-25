Warden::Strategies.add(:ip_address) do
  #VERA_IP = '::1'
  VERA_IP = '10.0.2.3'

  def valid?
    STDOUT.puts "COLIN COLIN COLIN - using new valid?, request.ip = #{request.ip}"
    request.ip == VERA_IP
  end

  def authenticate!
    STDOUT.puts "COLIN COLIN COLIN - using new authenticate!, request.ip = #{request.ip}"
    if request.ip == VERA_IP
      u = User.find_by(username: 'vera')
      u ? success!(u) : fail!
    end
  end
end
