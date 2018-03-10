# frozen_string_literal: true

require 'frebby/hooks'

class Frebby
  class << self
    def transform(key, into:)
      customize_key { |k| into if k == key.to_s }
    end

    # rubocop:disable Naming/UncommunicativeMethodParamName
    # ^ Because I think `as` makes sense here and allows for a nice DSL
    def pluralize(key, as: nil)
      customize_key { |k| as if k == key.to_s } unless as.nil?

      customize_value do |v, original_key:, transformed_key:, **_data|
        keys = [key.to_s, as.to_s].compact
        should_be_array = keys.include?(original_key) ||
                          keys.include?(transformed_key)
        should_be_array && !v.is_a?(Array) ? [v] : nil
      end
    end
    # rubocop:enable Naming/UncommunicativeMethodParamName

    def as_json(&blk)
      item = Frebby.new(&blk)
      Frebby._transform_result_hook(item).to_json
    end
  end
end
