defmodule FollowsConsumer do
    # function to accept Kafka messaged MUST be named "handle_message"
    # MUST accept arguments structured as shown here
    # MUST return :ok
    # Can do anything else within the function with the incoming message
    
    def handle_message(%{key: key, value: value} = message) do
      cond do
        message[:topic] == "follow_topic" ->
            uuid = FollowsService.follow(message[:key], message[:value])
            uuid = elem(elem(uuid, 1), 1)
            IO.puts("uuid: #{uuid}")
            # FollowsProducer.follow_msg({uuid, [message[:key], message[:value]]})
        true ->
            IO.inspect(message)
            IO.puts("#{key}: #{value}")
      end
      :ok
    end
    end