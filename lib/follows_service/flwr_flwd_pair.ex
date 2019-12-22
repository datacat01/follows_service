defmodule Follows.FlwrFlwdPair do
    use Ecto.Schema
    
    @primary_key false
  
    schema "follower_followed" do
      field :uuid, :string, primary_key: true
      field :follower_id, :string
      field :followed_id, :string
    end
  end