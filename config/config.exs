import Config

config :follows_service, Follows.Repo,
  # database: "follows_service_repo",
  # username: "olyapashneva",
  # password: "Uz2Vn2Wr",
  # hostname: "localhost",
  # port: "5432"
  database: "follows_service_db",
  username: "postgres",
  password: "postgres",
  hostname: "db"


config :kaffe,
  producer: [
    endpoints: [localhost: 9092],
    # endpoints references [hostname: port]. Kafka is configured to run on port 9092.
    # In this example, the hostname is localhost because we've started the Kafka server
    # straight from our machine. However, if the server is dockerized, the hostname will
    # be called whatever is specified by that container (usually "kafka")
    topics: ["follows_topic", "follows_all_topic", "follows_num_topic"], # add a list of topics you plan to produce messages to
  ]

config :kaffe,
  consumer: [
    endpoints: [localhost: 9092],               
    topics: ["follow_topic", "unfollow_topic", "followers_num_topic", "followers_all_topic"],     # the topic(s) that will be consumed
    consumer_group: "example-consumer-group",   # the consumer group for tracking offsets in Kafka
    message_handler: FollowsConsumer,           # the module that will process messages
  ]