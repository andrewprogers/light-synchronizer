class Bridge
  attr_reader :ip, :username, :api_path

  def initialize(ip, username)
    @ip = ip
    @username = username
    @api_path = "http://#{@ip}/api/#{@username}"
  end

  def path
    api_path
  end
end
