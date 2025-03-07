FROM ruby:3.4.2-alpine

RUN mkdir /app
WORKDIR /app
COPY . /app

ENV RUBY_YJIT_ENABLE=1
# ENV LANG=$LANG
# ENV RACK_ENV=$RACK_ENV
EXPOSE $PORT

RUN gem install bundler -v 2.4.4
RUN bundle install

CMD ./docker-entrypoint.sh
