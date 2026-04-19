defmodule BadgeReaderWeb.BadgeReaderController do
  use BadgeReaderWeb, :controller

  def login_page(conn, _params) do
    render(conn, :login_page)
  end

end
