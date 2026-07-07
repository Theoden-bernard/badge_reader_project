defmodule BadgeReaderWeb.PageControllerTest do
  use BadgeReaderWeb.ConnCase
  import BadgeReader.AccountsFixtures

  test "GET /", %{conn: conn} do
    user = user_fixture()
    conn = log_in_user(conn, user)

    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Dashboard"
  end
end
