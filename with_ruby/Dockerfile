FROM ruby:3.2

WORKDIR /app

COPY Gemfile /app/Gemfile
RUN bundle config path 'vendor/bundle'
RUN bundle install