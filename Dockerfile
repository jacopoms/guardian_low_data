FROM ruby:3.4.2

RUN mkdir /app
WORKDIR /app
COPY . /app

ENV RUBY_YJIT_ENABLE=1
# ENV LANG=$LANG
# ENV RACK_ENV=$RACK_ENV
EXPOSE $PORT

RUN gem install bundler -v 2.6.5
RUN bundle install

# Precompile assets and build the application
RUN bundle exec hanami assets precompile

CMD ./docker-entrypoint.sh
