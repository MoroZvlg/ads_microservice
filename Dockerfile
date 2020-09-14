FROM ruby:2.7.1-alpine3.12

RUN apk add --no-cache \
    build-base \
    tzdata \
    postgresql-dev

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./

RUN gem update bundler && \
    bundle config set withour 'development test' && \
    bundle install --jobs 4

COPY . .

EXPOSE 9292

CMD ["bin/puma"]