# frozen_string_literal: true

require 'frebby/hooks'
require 'frebby/transform'

Frebby.pluralize 'play', as: 'plays'
Frebby.pluralize 'task', as: 'tasks'
Frebby.pluralize 'handler', as: 'handlers'
Frebby.pluralize 'tag', as: 'tags'
Frebby.pluralize 'notify'

Frebby.customize_result { |result| result['plays'] }
