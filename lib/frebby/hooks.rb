# frozen_string_literal: true

class Frebby
  class << self
    # rubocop:disable Style/ClassVars

    @@hooks = {
      key: [],
      value: [],
      result: []
    }

    def customize_key(&hook)
      @@hooks[:key] << hook
    end

    def customize_value(&hook)
      @@hooks[:value] << hook
    end

    def customize_result(&hook)
      @@hooks[:result] << hook
    end

    def _transform_key_hook(key, **data)
      results = @@hooks[:key].map { |hook| hook.call(key, **data) }
      results.compact.first || key
    end

    def _transform_value_hook(value, **data)
      results = @@hooks[:value].map { |hook| hook.call(value, **data) }
      results.compact.first || value
    end

    def _transform_result_hook(result, **data)
      results = @@hooks[:result].map { |hook| hook.call(result, **data) }
      results.compact.first || result
    end

    # rubocop:enable Style/ClassVars
  end
end
