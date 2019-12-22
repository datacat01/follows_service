import Config

config :follows_service, Follows.Repo,
  database: "follows_service_repo",
  username: "olyapashneva",
  password: "Uz2Vn2Wr",
  hostname: "localhost"

config :follows_service, ecto_repos: [Follows.Repo]