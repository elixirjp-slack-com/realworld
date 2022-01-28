# Realworld

## Run on local machine

### Requirements

- Elixir
- PostgreSQL

Please refer to [Installation](https://hexdocs.pm/phoenix/installation.html#content).

### Run

```
$ mix setup
$ mix phx.server
```

Visit: http://localhost:4000/articles

### Test

```
$ mix test
```


## Run on [Docker](https://www.docker.com/)

### Requirements

- [Docker](https://www.docker.com/)

### Configuration

#### config/dev.exs

```diff
 config :realworld, Realworld.Repo,
   username: "postgres",
   password: "postgres",
-  hostname: "localhost",
+  hostname: "db",
   database: "realworld_dev",
   show_sensitive_data_on_connection_error: true,
   pool_size: 10

 config :realworld, RealworldWeb.Endpoint,
   # Binding to loopback ipv4 address prevents access from other machines.
   # Change to `ip: {0, 0, 0, 0}` to allow access from other machines.
-  http: [ip: {127, 0, 0, 1}, port: 4000],
+  http: [ip: {0, 0, 0, 0}, port: 4000],
   check_origin: false,
   code_reloader: true,
   debug_errors: true,
```

#### config/test.exs

```diff
 config :realworld, Realworld.Repo,
   username: "postgres",
   password: "postgres",
-  hostname: "localhost",
+  hostname: "db",
   database: "realworld_test#{System.get_env("MIX_TEST_PARTITION")}",
   pool: Ecto.Adapters.SQL.Sandbox,
   pool_size: 10
```

### Run

```
$ docker-compose build
$ docker-compose up
```

Visit: http://localhost:4000/articles

### Test

```
$ docker-compose run --rm web mix test
```

### Stop

```
$ docker-compose stop
```

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
  * [elixirjp.slack.com](https://join.slack.com/t/elixirjp/shared_invite/zt-ae8m5bad-WW69GH1w4iuafm1tKNgd~w): Hope you'll join us!
