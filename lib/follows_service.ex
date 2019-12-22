defmodule FollowsService do
  import Ecto.Query, only: [from: 2]

  def add_flwr_flwd(flwr_id, flwd_id) do
    flwr_flwd = %Follows.FlwrFlwdPair{}

    flwr_flwd = %{flwr_flwd | uuid: Ecto.UUID.bingenerate()}
    flwr_flwd = %{flwr_flwd | follower_id: flwr_id}
    flwr_flwd = %{flwr_flwd | followed_id: flwd_id}

    query = from(
      f in "follower_followed",
      where: f.follower_id == ^flwr_id and f.followed_id == ^flwd_id,
      select: f.uuid,
      limit: 1
    )
    if List.first(Follows.Repo.all(query)) == nil do
      Follows.Repo.insert(flwr_flwd)
    end
  end

  def hello do
    :world
  end
end
