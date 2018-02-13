require_relative '../lib/light'

describe Light::State do
  let(:light_data) { EXAMPLES[:lights]["1"] }
  let(:state) { Light::State.new(light_data['state']) }

  describe '#new' do
    it 'initializes with state hash' do
      expect(state.class).to eq(Light::State)
    end

    it 'has coorresponding accessor methods' do
      expect(state.on).to eq(light_data["state"]["on"])
      expect(state.bri).to eq(light_data["state"]["bri"])
      expect(state.hue).to eq(light_data["state"]["hue"])
      expect(state.sat).to eq(light_data["state"]["sat"])
      expect(state.effect).to eq(light_data["state"]["effect"])
      expect(state.xy).to eq(light_data["state"]["xy"])
      expect(state.ct).to eq(light_data["state"]["ct"])
      expect(state.alert).to eq(light_data["state"]["alert"])
      expect(state.colormode).to eq(light_data["state"]["colormode"])
      expect(state.mode).to eq(light_data["state"]["mode"])
      expect(state.reachable).to eq(light_data["state"]["reachable"])
    end
  end

  describe 'update' do
    let(:responses) { EXAMPLES[:put_state] }
    let(:state) {
      Light::State.new({
        "on" => false,
        "bri" => 120,
        "hue" => 2000
      })
    }

    it "updates successful attributes in the response" do
      expect(state.on).to_not eq(true)
      expect(state.bri).to_not eq(100)

      state.update(responses)

      expect(state.on).to eq(true)
      expect(state.bri).to eq(100)
    end

    it "does not update error attributes in the response" do
      initial_value = state.hue
      state.update(responses)
      expect(state.hue).to eq(initial_value)
    end
  end
end
