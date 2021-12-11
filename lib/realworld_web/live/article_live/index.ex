defmodule RealworldWeb.ArticleLive.Index do
  use RealworldWeb, :live_view

  alias Realworld.Blogs
  alias Realworld.Blogs.Article
  alias Realworld.Accounts

  on_mount RealWorldWeb.CurrentUserAssign

  @impl true
  def mount(_params, session, socket) do
    current_user =
      case session["user_token"] do
        nil -> nil
        token -> Accounts.get_user_by_session_token(token)
      end

    {:ok,
     socket
     |> assign(:articles, list_articles())
     |> assign(:tags, Blogs.list_tags())
     |> assign(:current_user, current_user)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Article")
    |> assign(:article, Blogs.get_article!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Article")
    |> assign(:article, %Article{author_id: socket.assigns.current_user.id})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Articles")
    |> assign(:article, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    article = Blogs.get_article!(id)
    {:ok, _} = Blogs.delete_article(article)

    {:noreply, assign(socket, :articles, list_articles())}
  end

  @impl true
  def handle_event("search_by_tag", %{"tag" => tag}, socket) do
    articles = Blogs.list_articles_by_tag(tag)
    {:noreply, assign(socket, :articles, articles)}
  end

  defp list_articles do
    Blogs.list_articles()
  end
end
