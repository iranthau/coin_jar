FROM ruby:2.6.6-alpine3.11

RUN apk add --update --no-cache \
  alpine-sdk \
  bash \
  build-base \
  coreutils \
  postgresql-dev \
  libxml2-dev \
  libxslt-dev \
  tzdata

ENV APP_HOME /coin_jar
WORKDIR $APP_HOME

COPY Gemfile* $APP_HOME/
RUN bundle install

COPY . $APP_HOME

CMD ["rails", "s"]