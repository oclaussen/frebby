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
require 'frebby/hooks'

class Frebby
  class << self
    def force_array(*keys)
      keys = keys.map(&:to_s)
      customize_value do |key, value|
        transformed_key = _transform_key_hook(key)
        do_force_array = keys.include?(key) || keys.include?(transformed_key)
        do_force_array && !value.is_a?(Array) ? [value] : nil
      end
    end

    def transform(key, value)
      key = key.to_s
      customize_key { |k| key == k ? value : nil }
    end

    def root_key(key)
      key = key.to_s
      customize_result { |result| result.key?(key) ? result[key] : nil }
    end
  end
end
