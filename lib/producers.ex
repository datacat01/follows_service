defmodule OtherProducer do
    def follow_msg({key, value}) do
      Kaffe.Producer.produce_sync("follow_topic", [{key, value}])
    end

    def unfollow_msg({key, value}) do
        Kaffe.Producer.produce_sync("unfollow_topic", [{key, value}])
    end
  
    # def send_my_message(key, value) do
    #   Kaffe.Producer.produce_sync(key, value)
    # end
  
    # def send_my_message(value) do
    #   Kaffe.Producer.produce_sync("sample_key", value)
    # end
  end


  defmodule FollowsProducer do
    def follow_msg({key, value}) do
      Kaffe.Producer.produce_sync("follows_topic", [{key, value}])
    end

    def unfollow_msg(key) do
        Kaffe.Producer.produce_sync("follows_topic", [{key, nil}])
    end
  
    # def send_my_message(key, value) do
    #   Kaffe.Producer.produce_sync(key, value)
    # end
  
    # def send_my_message(value) do
    #   Kaffe.Producer.produce_sync("sample_key", value)
    # end
  end