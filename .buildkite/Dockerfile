FROM ruby:alpine

WORKDIR /src

RUN apk update && \
    apk add --no-cache \
        bash \
        gcc \
        gcompat \
        git \
        libc-dev \
        make \
        yaml-dev

RUN adduser -D -u 9999 buildkite-agent && \
    chown -R buildkite-agent:buildkite-agent /src
ADD --chown=buildkite-agent:buildkite-agent Gemfile Gemfile.lock rack-security-middleware.gemspec ./
ADD --chown=buildkite-agent:buildkite-agent lib/rack-security-middleware/version.rb ./lib/rack-security-middleware/version.rb

USER buildkite-agent
RUN --mount=type=cache,target=/root/.cache/ \
    --mount=type=cache,target=/root/.bundle/cache \
    bundle install

ADD --chown=buildkite-agent:buildkite-agent . .
