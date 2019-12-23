defmodule OtherProducer do
    def send_my_message(topic, {key, value}) do # topics: "follow_topic", "unfollow_topic"
      Kaffe.Producer.produce_sync(topic, [{key, value}])
    end
  end


  defmodule FollowsProducer do
    def follows_service_msg({key, value}) do
      Kaffe.Producer.produce_sync("follows_topic", [{key, value}])
    end
  end