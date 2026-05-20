FROM ruby:4.0.4

RUN mkdir /app
WORKDIR /app
COPY . /app

ENV RUBY_YJIT_ENABLE=1
# ENV LANG=$LANG
# ENV RACK_ENV=$RACK_ENV
EXPOSE $PORT

RUN gem install bundler -v 4.0.10
RUN bundle install

# Create cache directories for Rack::Cache
RUN mkdir -p tmp/cache/rack/meta tmp/cache/rack/body

CMD ["./docker-entrypoint.sh"]
