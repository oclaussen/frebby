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

Frebby.customize_key do |key|
  {
    'play' => 'plays',
    'task' => 'tasks',
    'handler' => 'handlers',
    'tag' => 'tags'
  }[key]
end

Frebby.customize_value do |key, value|
  array_keys = %w[
    play
    task
    handler
    notify
    tag
  ]
  array_keys.include?(key) && !value.is_a?(Array) ? [value] : nil
end

Frebby.customize_result do |result|
  result['plays']
end
