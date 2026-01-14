FROM ruby:4.0.0

RUN mkdir /app
WORKDIR /app
COPY . /app

ENV RUBY_YJIT_ENABLE=1
# ENV LANG=$LANG
# ENV RACK_ENV=$RACK_ENV
EXPOSE $PORT

RUN gem install bundler -v 4.0.3
RUN bundle install

CMD ./docker-entrypoint.sh
