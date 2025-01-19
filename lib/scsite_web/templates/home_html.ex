defmodule ScsiteWeb.HomeHTML do
  @moduledoc """
  See the `/templates/home` directory for all templates available.
  """
  use ScsiteWeb, :html

  alias ScsiteWeb.ContactForm

  embed_templates "home/*"
end
