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
  end
end
