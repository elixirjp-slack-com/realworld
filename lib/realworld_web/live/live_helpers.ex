defmodule RealworldWeb.LiveHelpers do
  import Phoenix.LiveView.Helpers

  @doc """
  Renders a component inside the `RealworldWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal RealworldWeb.ArticleLive.FormComponent,
        id: @article.id || :new,
        action: @live_action,
        article: @article,
        return_to: Routes.article_index_path(@socket, :index) %>
  """
  def live_modal(component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]
    live_component(RealworldWeb.ModalComponent, modal_opts)
  end
end
