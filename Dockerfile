# syntax=docker/dockerfile:1.7

FROM ruby:4.0.4-alpine AS base

ENV APP_HOME=/app \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_WITHOUT=development:test \
    PORT=10000 \
    RACK_ENV=production \
    RUBY_YJIT_ENABLE=1

WORKDIR ${APP_HOME}

FROM base AS build

# Build-only packages for native gem extensions and git-sourced gems.
RUN apk add --no-cache build-base git

COPY Gemfile Gemfile.lock ./
RUN bundle install \
 && rm -rf /usr/local/bundle/cache/*.gem /usr/local/bundle/ruby/*/cache

COPY . .
RUN mkdir -p tmp/cache/rack/meta tmp/cache/rack/body \
 && chmod +x docker-entrypoint.sh

FROM base AS runtime

# Runtime libraries for native extensions (thin/eventmachine and dependencies).
RUN apk add --no-cache libgcc libstdc++

RUN addgroup -S app && adduser -S -G app app

COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /app /app

RUN chown -R app:app /app

USER app

EXPOSE 10000

CMD ["./docker-entrypoint.sh"]
