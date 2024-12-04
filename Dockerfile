FROM ruby:3.3.6-alpine3.20

COPY --link --chmod=750 entrypoint.sh /
COPY --link Gemfile Gemfile.lock /

RUN apk add --no-cache git bash \
	&& bundle install

ENTRYPOINT ["/entrypoint.sh"]
