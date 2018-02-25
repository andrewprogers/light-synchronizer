require_relative '../lib/light.rb'
require_relative '../lib/bridge.rb'


describe Light do
  let(:state) { light_data["state"] }
  let(:bridge) { Bridge.new(ENV['HUE_BRIDGE_IP'], ENV['HUE_BRIDGE_USERNAME']) }
  let(:state) { EXAMPLES[:lights]['1']["state"] }

  describe 'initialization' do
    it 'initializes with an id and bridge' do
      id = '1'
      light = Light.new(id, bridge)

      expect(light.id).to eq(id)
      expect(light.bridge).to eq(bridge)
    end

    it 'optionally initializes with a state and name' do
      light = Light.new('1', bridge, state: state)
      light2 = Light.new('1', bridge, name: 'bob', state: state)

      expect(light.state.class).to eq(Light::State)
      expect(light2.state.class).to eq(Light::State)

      expect(light.name.nil?).to eq(true)
      expect(light2.name).to eq('bob')
    end
  end

  describe '#pull' do
    it 'retrieves updated light state from bridge' do
      VCR.use_cassette('light#pull') do
        false_state = state
        false_state['bri'] = 0
        light = Light.new('1', bridge, state: false_state)

        expect(light.state.bri).to eq(0)
        light.pull
        expect(light.state.bri).to_not eq(0)
      end
    end

    it 'returns self' do
      VCR.use_cassette('light#pull_return') do
        light = Light.new('1', bridge)
        expect(light.pull).to eq(light)
      end
    end
  end

  describe '#send' do
    it 'sends a new state to the light' do
      VCR.use_cassette('light#send_on') do
        # Make a state change and push that change
        light = Light.new('1', bridge).pull
        original_value = light.state.on
        light.send(on: !original_value)

        # Check that change using a new probe
        light_probe = Light.new('1', bridge).pull
        expect(light_probe.state.on).to eq(!original_value)
      end
    end

    it 'updates the lights internal state when successful' do
      VCR.use_cassette('light_send_update') do
        # Make a state change and push that change
        light = Light.new('1', bridge).pull
        original_state = light.state
        original_value = light.state.on
        light.send(on: !original_value)

        expect(light.state).to eq(original_state)
        expect(light.state.on).to eq(!original_value)
      end
    end

    it 'doesnt update the lights internal state when unsuccessful' do
      VCR.use_cassette('light_send_no_update') do
        # Make a state change and push that change
        light = Light.new('1', bridge).pull
        original_value = light.state.on
        light.send(on: 'turn_off')

        expect(light.state.on).to_not eq('turn_off')
        expect(light.state.on).to eq(original_value)
      end
    end

    it 'returns self' do
      VCR.use_cassette('light#send_return') do
        light = Light.new('1', bridge).pull
        expect(light.send({})).to eq(light)
      end
    end
  end
end
