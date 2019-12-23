defmodule FollowsService do
  import Ecto.Query, only: [from: 2]

  def select_query(flwr_id, flwd_id) do
    query = from(
      f in "follower_followed",
      where: f.follower_id == ^flwr_id and f.followed_id == ^flwd_id,
      select: f.uuid,
      limit: 1
    )
  end

  def ini_struct(flwr_id, flwd_id, uuid) do
    flwr_flwd = %Follows.FlwrFlwdPair{}

    flwr_flwd = %{flwr_flwd | uuid: uuid}
    flwr_flwd = %{flwr_flwd | follower_id: flwr_id}
    flwr_flwd = %{flwr_flwd | followed_id: flwd_id}
  end


  def follow(flwr_id, flwd_id) do
    uuid = Ecto.UUID.bingenerate()
    flwr_flwd = ini_struct(flwr_id, flwd_id, uuid)
    query = select_query(flwr_id, flwd_id)

    Follows.Repo.transaction(fn repo ->
      if List.first(repo.all(query)) == nil do 
        repo.insert(flwr_flwd)
      end
    end)

    flwr_flwd
  end


  def unfollow(flwr_id, flwd_id) do

    query = select_query(flwr_id, flwd_id)

    Follows.Repo.transaction(fn repo ->
      cond do
        List.first(repo.all(query)) != nil ->
          uuid = List.first(repo.all(query))
          flwr_flwd = ini_struct(flwr_id, flwd_id, uuid)
          repo.delete(flwr_flwd)
          uuid
        true ->
          nil
      end
    end)
  end

  
end
