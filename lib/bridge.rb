require 'net/http'
require 'json'

class Bridge
  attr_reader :ip, :username, :api_path

  def initialize(ip, username)
    @ip = ip
    @username = username
  end

  def lights
    uri = URI(api_path + '/' + 'lights')
    response = Net::HTTP.get(uri)
    lights = JSON.parse(response)

    lights.map do |id, data|
      Light.new(id, self, state: data["state"], name: data["name"])
    end
  end

  def api_path
    "http://#{@ip}/api/#{@username}"
  end
end
