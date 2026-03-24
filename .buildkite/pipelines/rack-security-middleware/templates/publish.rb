# typed: false
# frozen_string_literal: true

Buildkite::Builder.template do |context|
  key :publish
  depends_on context[:depends_on]
  label 'Publish gem', emoji: :rubygems

  plugin :docker_compose, run: context[:runner]
  plugin :artifacts, upload: 'pkg/*.gem'
  agents queue: 'gemstash-publish'

  command 'rake build && gem push --key gemstash --host https://gemstash.zp-int.com/private pkg/*.gem'
  timeout_in_minutes 5
end
