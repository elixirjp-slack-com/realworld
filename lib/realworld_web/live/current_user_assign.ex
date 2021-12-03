defmodule RealWorldWeb.CurrentUserAssign do
  import Phoenix.LiveView

  def mount(_params, session, socket) do
    case session["user_token"] do
      nil ->
        {:cont, socket}
      token ->
        current_user = Realworld.Accounts.get_user_by_session_token(token)
        {:cont, assign(socket, :current_user, current_user)}
    end
  end
end