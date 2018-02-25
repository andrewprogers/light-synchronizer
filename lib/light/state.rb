class Light
  class State
    STATE_ATTRIBUTES = ['on', 'bri', 'hue', 'sat',
      'effect', 'xy', 'ct', 'alert', 'colormode',
      'mode', 'reachable']

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

      @dirty = true
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

    def clean!
      @dirty = false
    end

    def dirty?
      @dirty
    end

    def on=(value)
      @on = value
      @dirty = true
    end

    def method_missing(m, *args, &block)
      super unless m.to_s[-1] == '='
      attribute = m.to_s[0..-2]
      super unless STATE_ATTRIBUTES.include?(attribute)

      instance_variable_set("@#{attribute}".to_sym, args[0])
      @dirty = true
    end

    def to_h
      hash = {}
      hash["on"] = @on unless @on.nil?
      hash["bri"] = @bri unless @bri.nil?
      hash["hue"] = @hue unless @hue.nil?
      hash["sat"] = @sat unless @sat.nil?
      hash["effect"] = @effect unless @effect.nil?
      hash["xy"] =@xy unless @xy.nil?
      hash["ct"] =@ct unless @ct.nil?
      hash["alert"] =@alert unless @alert.nil?
      hash["colormode"] =@colormode unless @colormode.nil?
      hash["mode"] =@mode unless @mode.nil?
      hash["reachable"] =@reachable unless @reachable.nil?

      return hash
    end
  end
end
