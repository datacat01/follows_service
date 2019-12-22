defmodule OtherProducer do
    def follow(key, value) do
        Kaffe.Producer.produce_sync("follow_topic", %{key: key, value: value})
    end

    def unfollow(key, value) do
        Kaffe.Producer.produce_sync("unfollow_topic", %{key: key, value: value})
    end

end