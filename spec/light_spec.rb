require_relative '../lib/light.rb'

describe Light do
  let(:light_data) { EXAMPLES[:lights]["1"] }
  let(:light) { Light.new('1', EXAMPLES[:lights]["1"]["state"]) }
  let(:state) { light_data["state"] }

  it "initializes with id and state" do
    name = light_data["name"]

    light2 = Light.new('1', state, name)

    expect(light.class).to eq(Light)
    expect(light.id).to eq('1')

    expect(light2.name).to eq(name)
  end

  it 'initializes with light state' do
    expect(light.state).to_not eq(state)
    expect(light.state.class).to eq(Light::State)
  end
end
