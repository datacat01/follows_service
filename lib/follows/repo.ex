defmodule Follows.Repo do
  use Ecto.Repo,
    otp_app: :follows_service,
    adapter: Ecto.Adapters.Postgres
end
