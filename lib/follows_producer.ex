defmodule FollowsProducer do
    def follow({key, value}) do
        Kaffe.Producer.produce_sync("follow_topic", [{key, value}])
    end

    def unfollow(uuid) do
        if uuid != nil do
            Kaffe.Producer.produce_sync("followers_topic", [{uuid, 1}])
        end
    end

end