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

    Follows.Repo.transaction(fn repo ->
      if List.first(repo.all(query)) == nil do 
        repo.insert(flwr_flwd)
      end
    end)
  end


  def del_flwr_flwd(flwr_id, flwd_id) do

    query = from(
      f in "follower_followed",
      where: f.follower_id == ^flwr_id and f.followed_id == ^flwd_id,
      select: f.uuid,
      limit: 1
    )

    Follows.Repo.transaction(fn repo ->
      if List.first(repo.all(query)) != nil do

        flwr_flwd = %Follows.FlwrFlwdPair{}
        flwr_flwd = %{flwr_flwd | uuid: List.first(repo.all(query))}
        flwr_flwd = %{flwr_flwd | follower_id: flwr_id}
        flwr_flwd = %{flwr_flwd | followed_id: flwd_id}

        repo.delete(flwr_flwd)
      end
    end)
  end

  def hello do
    :world
  end
end
