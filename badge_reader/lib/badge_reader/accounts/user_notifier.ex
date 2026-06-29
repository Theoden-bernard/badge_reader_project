defmodule BadgeReader.Accounts.UserNotifier do
  @moduledoc """
  Handles dispatching transactional system emails to application users.

  This module leverages `Swoosh` to compile and transmit critical notification accounts,
  including passwordless magic link logins, email change confirmation links, and brand new
  account registration verification setups.

  ## Features

  * **Adaptive Delivery:** Automatically alters workflows when requested to deliver a login link, redirecting unconfirmed profiles through the onboarding confirmation flow first.
  * **Asynchronous Formatting:** Generates clean, secure, plain-text email bodies paired with dynamic verification tokens and callback URLs.

  ## Examples

  Sending multi-factor update sequences when an account requests a new email address:

    BadgeReader.Accounts.UserNotifier.deliver_update_email_instructions(user, "https://example.com/verify")

  Dispatching an instant authentication token loop:

    BadgeReader.Accounts.UserNotifier.deliver_login_instructions(user, "https://example.com/magic-link")
  """
  import Swoosh.Email

  alias BadgeReader.Accounts.User
  alias BadgeReader.Mailer

  # Delivers the email using the application mailer.
  defp deliver(recipient, subject, body) do
    email =
      new()
      |> to(recipient)
      |> from({"BadgeReader", "contact@example.com"})
      |> subject(subject)
      |> text_body(body)

    with {:ok, _metadata} <- Mailer.deliver(email) do
      {:ok, email}
    end
  end

  @doc """
  Deliver instructions to update a user email.
  """
  def deliver_update_email_instructions(user, url) do
    deliver(user.email, "Update email instructions", """

    ==============================

    Hi #{user.email},

    You can change your email by visiting the URL below:

    #{url}

    If you didn't request this change, please ignore this.

    ==============================
    """)
  end

  @doc """
  Deliver instructions to log in with a magic link.
  """
  def deliver_login_instructions(user, url) do
    case user do
      %User{confirmed_at: nil} -> deliver_confirmation_instructions(user, url)
      _ -> deliver_magic_link_instructions(user, url)
    end
  end

  defp deliver_magic_link_instructions(user, url) do
    deliver(user.email, "Log in instructions", """

    ==============================

    Hi #{user.email},

    You can log into your account by visiting the URL below:

    #{url}

    If you didn't request this email, please ignore this.

    ==============================
    """)
  end

  defp deliver_confirmation_instructions(user, url) do
    deliver(user.email, "Confirmation instructions", """

    ==============================

    Hi #{user.email},

    You can confirm your account by visiting the URL below:

    #{url}

    If you didn't create an account with us, please ignore this.

    ==============================
    """)
  end
end
