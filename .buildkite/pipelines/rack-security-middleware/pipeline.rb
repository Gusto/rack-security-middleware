# typed: false
# frozen_string_literal: true

def gem
  spec_files = Dir.glob("*.gemspec")
  return "unknown" if spec_files.empty?

  Gem::Specification.load(spec_files.first)
end

Buildkite::Builder.pipeline do
  plugin(:artifacts, "ssh://git@github.com/buildkite-plugins/artifacts-buildkite-plugin.git#v1.9.4")
  plugin(
    :docker_compose, "docker-compose#v5.4.1",
    config: ".buildkite/docker-compose.yml",
    mount_checkout: true,
    propagate_environment: true,
    require_prebuilt: true,
    tty: true,
    upload_container_logs: "always",
    progress: :plain
  )

  group do
    key :ci
    label "Run CI", emoji: :rocket

    command(:rspec, runner: :builder)
  end

  if Buildkite.env.branch == "main"
    block do
      key :confirm_publish
      block ":rocket: Publish to Gem Server"
      depends_on :ci
      prompt "Publish v#{gem.version} to gemstash?"
    end

    command(:publish, runner: :builder, depends_on: :confirm_publish)
  end
end
