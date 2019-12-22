defmodule FollowsConsumer do
# function to accept Kafka messaged MUST be named "handle_message"
# MUST accept arguments structured as shown here
# MUST return :ok
# Can do anything else within the function with the incoming message

def handle_message(%{key: key, value: value} = message) do
    cond do
        message[:topic] == "follow_topic" ->
            if key!=value do
                [uuid | flwr_flwd_id] = FollowsService.follow(key, value)
                FollowsProducer.follow(uuid, flwr_flwd_id)
            end
        message[:topic] == "unfollow_topic" ->
            if key!=value do
                uuid = elem((FollowsService.unfollow(key, value)), 1)
                FollowsProducer.unfollow(uuid)
            end
    end
  :ok
end
end