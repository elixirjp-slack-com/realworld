defmodule RealworldWeb.ArticleLive.Show do
  use RealworldWeb, :live_view

  alias Realworld.Blogs

  on_mount RealWorldWeb.CurrentUserAssign

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    article = Blogs.get_article!(id)
    %{
      live_action: action,
      current_user: user
    } = socket.assigns
    author_id = article.author_id

    if action == :edit && author_id != user.id do
      redirect_path = Routes.article_show_path(socket, :show, article)
      {:noreply,
       socket
       |> put_flash(:error, "You can't edit this article")
       |> push_redirect(to: redirect_path)}
    else
      {:noreply,
       socket
       |> assign(:page_title, page_title(socket.assigns.live_action))
       |> assign(:article, article)}
    end
  end

  defp page_title(:show), do: "Show Article"
  defp page_title(:edit), do: "Edit Article"
end
