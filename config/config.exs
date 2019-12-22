import Config

config :follows_service, Follows.Repo,
  database: "follows_service_repo",
  username: "olyapashneva",
  password: "Uz2Vn2Wr",
  hostname: "localhost"

config :follows_service, ecto_repos: [Follows.Repo]

config :kafka_ex,
  brokers: [
    {"localhost", 9092},
    # {"localhost", 9093},
    # {"localhost", 9094}
  ],

  consumer_group: "kafka_ex",
  client_id: "kafka_ex",
  disable_default_worker: false,
  sync_timeout: 3000,
  max_restarts: 10,
  max_seconds: 60,
  commit_interval: 5_000,
  commit_threshold: 100,
  sleep_for_reconnect: 400,
  use_ssl: false,
    # ssl_options: [
    #   cacertfile: File.cwd!() <> "/ssl/ca-cert",
    #   certfile: File.cwd!() <> "/ssl/cert.pem",
    #   keyfile: File.cwd!() <> "/ssl/key.pem"
    # ],
  kafka_version: "2.4.0"

env_config = Path.expand("#{Mix.env()}.exs", __DIR__)
  
if File.exists?(env_config) do
  import_config(env_config)
end