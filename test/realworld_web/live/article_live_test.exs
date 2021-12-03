defmodule RealworldWeb.ArticleLiveTest do
  use RealworldWeb.ConnCase

  import Phoenix.LiveViewTest
  import Realworld.BlogsFixtures

  @create_attrs %{body: "some body", title: "some title"}
  @update_attrs %{body: "some updated body", title: "some updated title"}
  @invalid_attrs %{body: nil, title: nil}

  setup :register_and_log_in_user

  defp create_article(%{user: user}) do
    article = article_fixture(%{author_id: user.id})
    %{article: article}
  end

  describe "Index" do
    setup [:create_article]

    test "lists all articles", %{conn: conn, article: article} do
      {:ok, _index_live, html} = live(conn, Routes.article_index_path(conn, :index))

      assert html =~ "Listing Articles"
      assert html =~ article.body
    end

    test "saves new article", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.article_index_path(conn, :index))

      assert index_live |> element("a", "New Article") |> render_click() =~
               "New Article"

      assert_patch(index_live, Routes.article_index_path(conn, :new))

      assert index_live
             |> form("#article-form", article: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#article-form", article: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.article_index_path(conn, :index))

      assert html =~ "Article created successfully"
      assert html =~ "some body"
    end

    # test "updates article in listing", %{conn: conn, article: article} do
    #   {:ok, index_live, _html} = live(conn, Routes.article_index_path(conn, :index))

    #   assert index_live |> element("#article-#{article.id} a", "Edit") |> render_click() =~
    #            "Edit Article"

    #   assert_patch(index_live, Routes.article_index_path(conn, :edit, article))

    #   assert index_live
    #          |> form("#article-form", article: @invalid_attrs)
    #          |> render_change() =~ "can&#39;t be blank"

    #   {:ok, _, html} =
    #     index_live
    #     |> form("#article-form", article: @update_attrs)
    #     |> render_submit()
    #     |> follow_redirect(conn, Routes.article_index_path(conn, :index))

    #   assert html =~ "Article updated successfully"
    #   assert html =~ "some updated body"
    # end

    # test "deletes article in listing", %{conn: conn, article: article} do
    #   {:ok, index_live, _html} = live(conn, Routes.article_index_path(conn, :index))

    #   assert index_live |> element("#article-#{article.id} a", "Delete") |> render_click()
    #   refute has_element?(index_live, "#article-#{article.id}")
    # end
  end

  describe "Show" do
    setup [:create_article]

    test "displays article", %{conn: conn, article: article} do
      {:ok, _show_live, html} = live(conn, Routes.article_show_path(conn, :show, article))

      assert html =~ "Show Article"
      assert html =~ article.body
    end

    test "updates article within modal", %{conn: conn, article: article} do
      {:ok, show_live, _html} = live(conn, Routes.article_show_path(conn, :show, article))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Article"

      assert_patch(show_live, Routes.article_show_path(conn, :edit, article))

      assert show_live
             |> form("#article-form", article: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#article-form", article: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.article_show_path(conn, :show, article))

      assert html =~ "Article updated successfully"
      assert html =~ "some updated body"
    end
  end
end
