defmodule BadgeReaderWeb.BadgeReaderController do
  use BadgeReaderWeb, :controller

  # alias ElixirLS.LanguageServer.Plugins.Phoenix

  # import BadgeReaderWeb.Components.Test

  def login_page(conn, _params) do
    render(conn, :login_page)
  end

  def dashboard(conn, _params) do
    render(conn, :dashboard)
  end
end
