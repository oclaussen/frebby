# frozen_string_literal: true

#
# Copyright 2017, Ole Claussen <claussen.ole@gmail.com>
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
  module Config
    # rubocop:disable Style/ClassVars
    @@config = {
      force_array: [],
      transformations: {},
      root_key: nil
    }

    def force_array(*keys)
      @@config[:force_array] += keys
    end

    def transform(key, value)
      @@config[:transformations][key.to_s] = value
    end

    def root_key(key)
      @@config[:root_key] = key
    end

    def _transform_key(original_key)
      key = super
      @@config[:transformations][key] || key
    end

    def _transform_value(original_value, original_key, _target)
      value = super
      key = _transform_key(original_key)
      fa_keys = @@config[:force_array]
      force_array = fa_keys.include?(original_key) || fa_keys.include?(key)
      force_array && !value.is_a?(Array) ? [value] : value
    end

    def _transform_result(result)
      root_key = @@config[:root_key]
      return result if root_key.nil? || !result.key?(root_key)
      result[root_key]
    end
    # rubocop:enable Style/ClassVars
  end
end

Frebby.singleton_class.prepend(Frebby::Config)
