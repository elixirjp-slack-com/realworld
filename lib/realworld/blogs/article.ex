defmodule Realworld.Blogs.Article do
  use Ecto.Schema
  import Ecto.Changeset

  alias Realworld.Blogs.Comment
  alias Realworld.Blogs.Tag
  alias Realworld.Blogs.ArticleTag

  schema "articles" do
    field :body, :string
    field :title, :string
    has_many :comments, Comment
    many_to_many :tags, Tag, join_through: ArticleTag, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(article, attrs, tags \\ []) do
    article
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
    |> put_assoc(:tags, tags)
  end
end
