FROM ruby:3.2.0-alpine3.17

COPY --chmod=750 entrypoint.sh /
COPY Gemfile Gemfile.lock /

RUN apk add --no-cache git \
	&& bundle install

ENTRYPOINT ["/entrypoint.sh"]
