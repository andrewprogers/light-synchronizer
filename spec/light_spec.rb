require_relative '../lib/light.rb'

describe Light do
  describe 'class methods' do

  end

  it "initializes with id and state" do
    id = 1
    light_data = EXAMPLES[:lights]['1']
    state = light_data["state"]
    name = light_data["name"]

    light = Light.new(id, state)
    light2 = Light.new(id, state, name)

    expect(light.class).to eq(Light)
    expect(light.id).to eq(id)
    expect(light.state).to eq(state)

    expect(light2.name).to eq(name)
  end
end
