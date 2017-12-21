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
      transformations: {}
    }

    def force_array(*keys)
      @@config[:force_array] += keys.map(&:to_s)
    end

    def transform(key, value)
      @@config[:transformations][key.to_s] = value
    end

    def _transform_key(original_key)
      key = super
      @@config[:transformations][key] || key
    end

    def _transform_value(original_value, key)
      value = super
      if @@config[:force_array].include?(key) && !value.is_a?(Array)
        [value]
      else
        value
      end
    end
    # rubocop:enable Style/ClassVars
  end
end

Frebby.singleton_class.prepend(Frebby::Config)
