defmodule Realworld.Repo.Migrations.AddColumnAutherIdToComments do
  use Ecto.Migration

  def change do
    alter table("comments") do
      add :author_id, references(:users, on_delete: :nothing)
    end
  end
end
