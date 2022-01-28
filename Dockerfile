FROM hexpm/elixir:1.13.1-erlang-24.2.1-debian-bullseye-20210902-slim

RUN apt-get update && \
    apt-get install --yes build-essential inotify-tools postgresql-client && \
    apt-get clean

RUN mix local.hex --force && \
  mix archive.install hex phx_new --force && \
  mix local.rebar --force

ADD . /app
WORKDIR /app
EXPOSE 4000

CMD ["/app/entrypoint.sh"]