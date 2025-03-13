defmodule ScsiteWeb.HomeController do
  use ScsiteWeb, :controller

  alias Scsite.CMS

  def home(conn, _params) do
    render(conn, :home, form: %{"email" => "", "message" => ""})

    # case CMS.get_home_page_content() do
    #   {:ok, content} -> render_home(conn, content, params)

    #   {:error, _reason} -> put_flash(conn, :error, "Error cargando el contenido.")
    # end
  end

  def render_home(conn, content, _params) do



    # Home page is often custom made, so skip the app layout.
    render(conn, :home, content: content, layout: false)
  end

  def faqs(conn, _params) do
    render(conn, :faqs, page_title: "Preguntas Frecuentes")
  end

  def pricing(conn, _params) do
    conn
    |> put_view(ScsiteWeb.PricingHTML)
    |> render(:pricing, form: %{"email" => "", "message" => ""}, page_title: "Planes")
  end
end
