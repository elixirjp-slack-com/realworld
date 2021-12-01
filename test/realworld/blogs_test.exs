defmodule Realworld.BlogsTest do
  use Realworld.DataCase

  alias Realworld.Blogs

  describe "articles" do
    alias Realworld.Blogs.Article

    import Realworld.BlogsFixtures

    @invalid_attrs %{body: nil, title: nil}

    test "list_articles/0 returns all articles" do
      article = article_fixture()
      assert Blogs.list_articles() == [article]
    end

    test "get_article!/1 returns the article with given id" do
      article = article_fixture()
      assert Blogs.get_article!(article.id) == article
    end

    test "create_article/1 with valid data creates a article" do
      valid_attrs = %{body: "some body", title: "some title"}

      assert {:ok, %Article{} = article} = Blogs.create_article(valid_attrs)
      assert article.body == "some body"
      assert article.title == "some title"
    end

    test "create_article/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blogs.create_article(@invalid_attrs)
    end

    test "update_article/2 with valid data updates the article" do
      article = article_fixture()
      update_attrs = %{body: "some updated body", title: "some updated title"}

      assert {:ok, %Article{} = article} = Blogs.update_article(article, update_attrs)
      assert article.body == "some updated body"
      assert article.title == "some updated title"
    end

    test "update_article/2 with invalid data returns error changeset" do
      article = article_fixture()
      assert {:error, %Ecto.Changeset{}} = Blogs.update_article(article, @invalid_attrs)
      assert article == Blogs.get_article!(article.id)
    end

    test "delete_article/1 deletes the article" do
      article = article_fixture()
      assert {:ok, %Article{}} = Blogs.delete_article(article)
      assert_raise Ecto.NoResultsError, fn -> Blogs.get_article!(article.id) end
    end

    test "change_article/1 returns a article changeset" do
      article = article_fixture()
      assert %Ecto.Changeset{} = Blogs.change_article(article)
    end

    @tag :list_articles_by_tag
    test "list_articles_by_tag/1" do
      {:ok, %{article: article1}} =
        Blogs.insert_article_with_tags(%{
          title: "t",
          body: "b",
          tags_string: "Elixir, Phoenix, Nerves, Nx"
        })

      {:ok, %{article: article2}} =
        Blogs.insert_article_with_tags(%{
          title: "t",
          body: "b",
          tags_string: "Elixir"
        })

      assert Blogs.list_articles_by_tag("Elixir")
             |> Enum.any?(&(&1.id == article1.id))

      assert Blogs.list_articles_by_tag("Elixir")
             |> Enum.any?(&(&1.id == article2.id))

      assert Blogs.list_articles_by_tag("Phoenix")
             |> Enum.any?(&(&1.id == article1.id))

      refute Blogs.list_articles_by_tag("Phoenix")
             |> Enum.any?(&(&1.id == article2.id))

      assert Blogs.list_articles_by_tag("Python") |> Enum.count() |> Kernel.==(0)
    end
  end

  describe "comments" do
    alias Realworld.Blogs.Comment

    import Realworld.BlogsFixtures

    @invalid_attrs %{body: nil}

    test "list_comments/0 returns all comments" do
      comment = comment_fixture()
      assert Blogs.list_comments() == [comment]
    end

    test "get_comment!/1 returns the comment with given id" do
      comment = comment_fixture()
      assert Blogs.get_comment!(comment.id) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      valid_attrs = %{body: "some body", article_id: Map.get(article_fixture(), :id)}

      assert {:ok, %Comment{} = comment} = Blogs.create_comment(valid_attrs)
      assert comment.body == "some body"
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blogs.create_comment(@invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      comment = comment_fixture()
      update_attrs = %{body: "some updated body"}

      assert {:ok, %Comment{} = comment} = Blogs.update_comment(comment, update_attrs)
      assert comment.body == "some updated body"
    end

    test "update_comment/2 with invalid data returns error changeset" do
      comment = comment_fixture()
      assert {:error, %Ecto.Changeset{}} = Blogs.update_comment(comment, @invalid_attrs)
      assert comment == Blogs.get_comment!(comment.id)
    end

    test "delete_comment/1 deletes the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{}} = Blogs.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> Blogs.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      comment = comment_fixture()
      assert %Ecto.Changeset{} = Blogs.change_comment(comment)
    end
  end
end
