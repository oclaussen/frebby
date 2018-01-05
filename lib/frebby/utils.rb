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
    def pluralize(key, as: nil)
      customize_key { |k| as if k == key.to_s } unless as.nil?

      customize_value do |v, original_key:, transformed_key:, **_data|
        keys = [key.to_s, as.to_s].compact
        should_be_array = keys.include?(original_key) ||
                          keys.include?(transformed_key)
        should_be_array && !v.is_a?(Array) ? [v] : nil
      end
    end
  end
end
