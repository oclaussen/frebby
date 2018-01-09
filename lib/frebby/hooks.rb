# frozen_string_literal: true

#
# Copyright 2018, Ole Claussen <claussen.ole@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

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

    def _transform_key_hook(key, data)
      results = @@hooks[:key].map { |hook| hook.call(key, **data) }
      results.compact.first || key
    end

    def _transform_value_hook(value, data)
      results = @@hooks[:value].map { |hook| hook.call(value, **data) }
      results.compact.first || value
    end

    def _transform_result_hook(result, data)
      results = @@hooks[:result].map { |hook| hook.call(result, **data) }
      results.compact.first || result
    end

    # rubocop:enable Style/ClassVars
  end
end
