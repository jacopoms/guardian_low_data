FROM ruby:3.2.0

RUN mkdir /app
WORKDIR /app
COPY . /app

ARG $LANG
ARG $RACK_ENV
ARG $PORT

ENV LANG $LANG
ENV RACK_ENV $RACK_ENV
ENV PORT $PORT

RUN echo $(ruby --yjit -v)

RUN gem install bundler -v 2.4.4
RUN bundle install

