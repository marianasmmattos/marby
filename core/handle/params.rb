module Handle
  class Params < OpenStruct
  end

  class ParamsParser
    def self.call(params)
      json_params = JSON.generate(params)
      symbolized_params = symbolize_recursive(json_params)

      ::Handle::Params.new(**symbolized_params)
    end

    private

    def self.symbolize_recursive(hash)
      new_hash = JSON.parse(hash)

      {}.tap do |h|
        new_hash.each { |key, value| h[key.to_sym] = map_value(value) }
      end
    end

    def self.map_value(value)
      case value
      when Hash
        symbolize_recursive(value)
      when Array
        value.map { |v| map_value(v) }
      else
        value
      end
    end
  end
end