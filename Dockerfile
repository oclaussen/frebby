FROM ruby:2.4-alpine as build

RUN apk add --no-cache alpine-sdk

COPY . /build

RUN cd /build \
 && bundle install \
 && bundle exec rake all

FROM ruby:2.4-alpine

COPY --from=build /build/pkg/frebby-*.gem /
RUN gem install /frebby-*.gem \
 && rm /frebby-*.gem

ENTRYPOINT ["frebby"]
