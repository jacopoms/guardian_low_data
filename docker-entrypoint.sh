#!/bin/sh

RUBYOPT=--yjit bundle exec thin -R config.ru start -p $PORT -e $RACK_ENV
