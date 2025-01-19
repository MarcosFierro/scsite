defmodule ScsiteWeb.HomeController do
  use ScsiteWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home)
  end

  def faqs(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :faqs)
  end
end
