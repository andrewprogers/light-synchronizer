require_relative '../lib/bridge.rb'

describe Bridge do
  let(:bridge) { Bridge.new(ENV['HUE_BRIDGE_IP'], ENV['HUE_BRIDGE_USERNAME']) }

  describe 'initialization' do
    it 'creates a new bridge connection with specified ip address and username' do
      expect(bridge.class).to eq(Bridge)
    end
  end

  describe '#lights' do
    it 'returns an array of light objects' do
      VCR.use_cassette('lights') do
        lights = bridge.lights

        expect(lights.class).to eq(Array)
        expect(lights.length > 0).to eq(true)
        expect(lights.all? { |light| light.class == Light }).to eq(true)
      end
    end

    it 'returns light objects that reference the bridge' do
      VCR.use_cassette('lights') do
        lights = bridge.lights

        expect(lights.all? { |light| light.bridge == bridge }).to eq(true)
      end
    end
  end
end
