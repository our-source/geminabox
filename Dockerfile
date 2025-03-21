FROM docker.io/ruby:3.3-bookworm

RUN bundle config --global frozen 1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY . /usr/src/app
RUN bundle install

EXPOSE 80

ENTRYPOINT ["bundle", "exec", "rackup", "--host", "0.0.0.0", "--port", "80"]
