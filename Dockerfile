FROM ruby:2.6.3

RUN mkdir /guardian-low-data
WORKDIR /guardian-low-data
COPY . /guardian-low-data


ENV LANG en_US.UTF-8
ENV RACK_ENV development
ENV PORT 3000

RUN gem install bundler -v 2.0.2
RUN bundle install

CMD bundle exec thin -R config.ru start -p $PORT -e $RACK_ENV