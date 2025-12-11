defmodule BadgeReaderWeb.PageController do
  use BadgeReaderWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
