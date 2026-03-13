defmodule BadgeReaderWeb.BadgeReaderController do
  use BadgeReaderWeb, :controller

  def home_page(conn, _params) do
    render(conn, :home_page)
  end
end
