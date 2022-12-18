FROM ruby:3.0.3

RUN mkdir /app
WORKDIR /app
COPY . /app

ARG $LANG
ARG $RACK_ENV
ARG $PORT

ENV LANG $LANG
ENV RACK_ENV $RACK_ENV
ENV PORT $PORT


RUN gem install bundler -v 2.2.32
RUN bundle install

CMD bundle exec thin -R config.ru start -p $PORT -e $RACK_ENV
