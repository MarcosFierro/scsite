defmodule ScsiteWeb.ContactController do
  use ScsiteWeb, :controller

  def home(conn, _params) do
    render(conn, :home, layout: false)
  end
end
