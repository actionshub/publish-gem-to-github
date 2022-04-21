FROM ruby:3.1-alpine

LABEL "com.github.actions.name"="Publish Gem to GitHub" \
  "com.github.actions.icon"="edit-3" \
  "com.github.actions.color"="red" \
  "com.github.actions.description"="Build and publish your gem to GitHub"

COPY LICENSE README.md entrypoint.sh /

RUN apk add --no-cache git \
  && gem install bundler keycutter

ENTRYPOINT ["/entrypoint.sh"]
