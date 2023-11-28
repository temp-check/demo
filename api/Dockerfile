# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.2.2
FROM registry.docker.com/library/ruby:$RUBY_VERSION-bullseye as base

# Rails app lives here
WORKDIR /rails

# Set production environment
ENV RAILS_ENV="production" \
  BUNDLE_DEPLOYMENT="1" \
  BUNDLE_PATH="/usr/local/bundle" \
  BUNDLE_WITHOUT="development"

# Throw-away build stage to reduce size of final image
FROM base as build

# Implementing retry logic for apt-get commands in build stage
RUN apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  for i in {1..7}; do apt-get update -qq && break || sleep 15; done && \
  for i in {1..5}; do apt-get install --no-install-recommends -y --fix-missing build-essential git pkg-config libvips && break || sleep 10; done

# Install application gems
COPY Gemfile Gemfile.lock ./

RUN bundle install && \
  rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git

# Copy application code
COPY . .

# Final stage for app image
FROM base

# Retry logic for apt-get commands in final stage
RUN for i in {1..5}; do apt-get update -qq && break || sleep 15; done && \
  for i in {1..5}; do apt-get install --no-install-recommends -y curl && break || sleep 15; done && \
  rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Copy built artifacts: gems, application
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# Run and own only the runtime files as a non-root user for security
RUN useradd rails --create-home --shell /bin/bash && \
  chown -R rails:rails db log storage tmp
USER rails:rails

# Entrypoint prepares the database.
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000
CMD ["./bin/rails", "server"]
