defmodule ScsiteWeb.ContactController do
  use ScsiteWeb, :controller

  @formspree_url "https://formspree.io/f"

  def submit(conn, params) do
    client = formspreeTeslaClient()
    IO.inspect(client)
    IO.inspect(params)
    body = Jason.encode!(%{
      email: params["email"],
      message: params["message"],
      name: params["name"],
      phone: params["phone"]
    })

    case Tesla.post(client, "/#{System.get_env("FORMSPREE_CONTACT_FORM_ID")}", body) do
      {:ok, %Tesla.Env{status: 302}} ->
        conn
        |> put_flash(:info, "Thank you for contacting us! We'll get back to you soon.")
        |> redirect(to: ~p"/")

      {:ok, %Tesla.Env{status: status}} ->
        conn
        |> put_flash(:error, "Something went wrong. Please try again. (#{status})")
        |> redirect(to: ~p"/")

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Unable to process your request. Please try again later.")
        |> redirect(to: ~p"/")
    end
  end

  def formspreeTeslaClient do
    Tesla.client([
      Tesla.Middleware.JSON,
      {Tesla.Middleware.BaseUrl, @formspree_url}
    ])
  end

  def new(conn, _params) do
    render(conn, :contact, form: %{"email" => "", "message" => ""}, page_title: "Contacto")
  end
end
