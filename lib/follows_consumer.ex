defmodule FollowsConsumer do
    # function to accept Kafka messaged MUST be named "handle_message"
    # MUST accept arguments structured as shown here
    # MUST return :ok
    # Can do anything else within the function with the incoming message
    
    def handle_message(%{key: key, value: value} = message) do
      cond do
        message[:topic] == "follow_topic" ->
            IO.puts("I AM HEEEEREEEE1")
            uuid = FollowsService.follow(message[:key], message[:value])
            uuid = elem(elem(uuid, 1), 1)
            IO.puts("#{uuid}")
            FollowsProducer.follows_service_msg({uuid, [message[:key], message[:value]]})
        
        message[:topic] == "unfollow_topic" ->
            IO.puts("I AM HEEEEREEEE2")
            uuid = FollowsService.unfollow(message[:key], message[:value])
            IO.puts("#{uuid}")
            if elem(uuid, 1) != nil do
                uuid = elem(elem(uuid, 1), 1)
                IO.puts("#{uuid}")
                FollowsProducer.follows_service_msg({uuid, nil})
            end
        true ->
            IO.inspect(message)
            IO.puts("#{key}: #{value}")
      end
      :ok
    end
    end