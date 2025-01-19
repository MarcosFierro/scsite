defmodule ScsiteWeb.ContactController do
  use ScsiteWeb, :controller

  def new(conn, _params) do
    render(conn, :contact)
  end
end
