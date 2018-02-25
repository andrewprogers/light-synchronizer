require 'net/http'
require 'json'

require_relative 'light/state'

class Light
  attr_reader :id, :state, :name, :bridge

  def initialize(id, bridge, options = {})
    @id = id
    @bridge = bridge
    if options[:state].nil?
      @state = nil
    else
      @state = State.new(options[:state])
    end
    @name = options[:name]
  end

  def pull
    uri = URI("#{@bridge.api_path}/lights/#{@id}")
    data = JSON.parse(Net::HTTP.get(uri))
    if data["state"].nil?
      raise StandardError
    else
      @state = State.new(data["state"])
    end
    self
  end

  def push
    uri = URI("#{@bridge.api_path}/lights/#{@id}/state")
    req = Net::HTTP::Put.new(uri)
    req.body = state.to_h.to_json

    response = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end
    pull
  end
end
