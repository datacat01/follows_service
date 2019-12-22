defmodule Follows.Repo.Migrations.CreateFlwrFlwd do
  use Ecto.Migration

  def change do
    create table(:follower_followed, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add :follower_id, :string
      add :followed_id, :string
      add :followed_id, :string
    end
  end
end
