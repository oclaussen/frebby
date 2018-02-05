# frozen_string_literal: true

require 'frebby/hooks'
require 'frebby/transform'

Frebby.pluralize 'play', as: 'plays'
Frebby.pluralize 'task', as: 'tasks'
Frebby.pluralize 'pre_task', as: 'pre_tasks'
Frebby.pluralize 'post_task', as: 'post_tasks'
Frebby.pluralize 'handler', as: 'handlers'
Frebby.pluralize 'tag', as: 'tags'
Frebby.pluralize 'notify'

Frebby.customize_result { |result| result['plays'] }
