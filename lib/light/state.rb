class Light
  class State
    attr_reader :on, :bri, :hue, :sat, :effect, :xy, :ct, :alert,
      :colormode, :mode, :reachable

    def initialize(state_hash)
      @on = state_hash["on"]
      @bri = state_hash["bri"]
      @hue = state_hash["hue"]
      @sat = state_hash["sat"]
      @effect = state_hash["effect"]
      @xy = state_hash["xy"]
      @ct = state_hash["ct"]
      @alert = state_hash["alert"]
      @colormode = state_hash["colormode"]
      @mode = state_hash["mode"]
      @reachable = state_hash["reachable"]
    end

    def update(responses)
      responses.each do |response|
        if response.keys.include?("success")
          success = response["success"]
          resource = success.keys[0].split('/')[-1]
          instance_variable = "@#{resource}".to_sym

          resource_value = success.values[0]
          if self.instance_variable_defined?(instance_variable)
            self.instance_variable_set(instance_variable, resource_value)
          end
        end
      end
    end

  end
end
