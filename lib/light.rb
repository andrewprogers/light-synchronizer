class Light
  attr_reader :id, :state, :name
  def initialize(id, state, name = nil)
    @id = id
    @state = state
    @name = name
  end
end
