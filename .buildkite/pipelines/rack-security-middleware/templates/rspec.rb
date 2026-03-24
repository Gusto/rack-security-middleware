# typed: false
# frozen_string_literal: true

Buildkite::Builder.template do |context|
  key :rspec
  label 'RSpec', emoji: :rspec
  command 'bundle exec rspec'

  plugin :docker_compose, run: context[:runner]

  default_automatic_retries
end
