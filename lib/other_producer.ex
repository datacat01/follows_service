defmodule OtherProducer do
    def follow({key, value}) do
        Kaffe.Producer.produce_sync("follow_topic", [{key, value}])
    end

    def unfollow({key, value}) do
        Kaffe.Producer.produce_sync("unfollow_topic", [{key, value}])
    end

end