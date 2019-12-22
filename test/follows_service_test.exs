defmodule FollowsServiceTest do
  use ExUnit.Case
  doctest FollowsService

  test "greets the world" do
    assert FollowsService.hello() == :world
  end
end
