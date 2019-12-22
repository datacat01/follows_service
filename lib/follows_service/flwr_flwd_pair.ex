defmodule Follows.FlwrFlwdPair do
    use Ecto.Schema
  
    schema "flwr_flwd_pair" do
      field :uuid, :string
      field :follower_id, :string
      field :followed_id, :integer
    end
  end