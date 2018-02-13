require_relative 'light/state'

class Light
  attr_reader :id, :state, :name
  
  def initialize(id, state, name = nil)
    @id = id
    @state = State.new(state)
    @name = name
  end
end
