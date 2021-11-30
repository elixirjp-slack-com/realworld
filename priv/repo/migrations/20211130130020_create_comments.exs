defmodule Realworld.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :body, :string, null: false
      add :article_id, references(:articles, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:comments, [:article_id])
  end
end
