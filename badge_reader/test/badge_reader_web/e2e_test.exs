defmodule BadgeReaderWeb.E2eTest do
  use BadgeReaderWeb.FeatureCase, async: false

  @moduletag :e2e

  alias Wallaby.Query

  test "l'utilisateur peut voir la page d'accueil et naviguer", %{session: session} do
    session
    |> visit("/users/log-in")
    |> fill_in(Query.css("#login_form_password input[type='email']"), with: "tb@colint.school")
    |> fill_in(Query.text_field("mot de passe"), with: "Theoden1203!")
    |> Kernel.tap(fn _ -> :timer.sleep(3000) end)
    |> click(Query.css("#login_form_password button[name='user[remember_me]']"))
    |> Kernel.tap(fn _ -> :timer.sleep(1000) end)
    |> assert_has(Query.css("h1", text: "Dashboard"))
  end
end
