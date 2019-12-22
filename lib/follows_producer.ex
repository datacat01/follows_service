defmodule FollowsProducer do
    def follow(uuid, value) do
        Kaffe.Producer.produce_sync("follow_topic", [uuid, value])
    end

    def unfollow(uuid) do
        if uuid != nil do
            Kaffe.Producer.produce_sync("followers_topic", [uuid, nil])
        end
    end

end