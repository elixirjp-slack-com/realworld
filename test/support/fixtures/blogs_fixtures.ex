defmodule Realworld.BlogsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Realworld.Blogs` context.
  """

  @doc """
  Generate a article.
  """
  def article_fixture(attrs \\ %{}) do
    {:ok, article} =
      attrs
      |> Enum.into(%{
        body: "some body",
        title: "some title"
      })
      |> Realworld.Blogs.create_article()

    article
  end
end
