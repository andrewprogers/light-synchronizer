require_relative '../lib/light.rb'
require_relative '../lib/bridge.rb'

describe Light do
  let(:state) { light_data["state"] }
  let(:bridge) { Bridge.new(ENV['HUE_BRIDGE_IP'], ENV['HUE_BRIDGE_USERNAME']) }
  let(:state) { EXAMPLES[:lights]['1']["state"] }

  it 'initializes with an id and bridge' do
    id = 1
    light = Light.new(id, bridge)

    expect(light.id).to eq(id)
    expect(light.bridge).to eq(bridge)
  end

  it 'it optionally initializes with a state and name' do
    light = Light.new(1, bridge, state: state)
    light2 = Light.new(1, bridge, name: 'bob', state: state)

    expect(light.state.class).to eq(Light::State)
    expect(light2.state.class).to eq(Light::State)

    expect(light.name.nil?).to eq(true)
    expect(light2.name).to eq('bob')
  end

  xit "initializes with id, bridge, and name" do
    light_data = EXAMPLES[:lights]["1"]
    bridge =
    name = light_data["name"]

    light2 = Light.new('1', state, name)

    expect(light.class).to eq(Light)
    expect(light.id).to eq('1')

    expect(light2.name).to eq(name)
  end

  describe 'state updating methods' do
    describe '#state' do
      xit 'sends '
    end
  end
end
