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
end
