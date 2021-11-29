defmodule Realworld.Repo do
  use Ecto.Repo,
    otp_app: :realworld,
    adapter: Ecto.Adapters.Postgres
end
