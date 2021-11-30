defmodule Realworld.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :body, :string
      add :article_id, references(:articles, on_delete: :nothing)

      timestamps()
    end

    create index(:comments, [:article_id])
  end
end
