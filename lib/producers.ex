defmodule OtherProducer do
    def send_my_message(topic, {key, value}) do # topics: "follow_topic", "unfollow_topic"
      Kaffe.Producer.produce_sync(topic, [{key, value}])
    end

    def send_my_message(topic, key) do # topics: "followers_num_topic", "followers_all_topic"
      Kaffe.Producer.produce_sync(topic, [{key, "none"}])
    end
  end


defmodule FollowsProducer do
    def follows_service_msg({key, value}) do
      Kaffe.Producer.produce_sync("follows_topic", [{key, value}])
    end
    def follows_num({key, value}) do
        Kaffe.Producer.produce_sync("follows_num_topic", [{key, value}])
    end
    def all_followers({key, value}) do
        Kaffe.Producer.produce_sync("follows_all_topic", [{key, value}])
    end
  end