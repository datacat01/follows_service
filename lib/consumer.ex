defmodule FollowsConsumer do
# function to accept Kafka messaged MUST be named "handle_message"
# MUST accept arguments structured as shown here
# MUST return :ok
# Can do anything else within the function with the incoming message

def handle_message(%{key: key, value: value} = message) do
    cond do
        message[:topic] == "follow_topic" ->
            if key!=value do
                FollowsService.follow(key, value)
            end
        message[:topic] == "unfollow_topic" ->
            if key!=value do
                [response | uuid] = Tuple.to_list(FollowsService.unfollow(key, value))
                FollowsProducer.unfollow(uuid[:ok])
            end
    end
  :ok
end
end