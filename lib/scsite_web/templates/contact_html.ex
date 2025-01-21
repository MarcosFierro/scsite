defmodule ScsiteWeb.ContactHTML do
  @moduledoc """
  See the `/templates/contact` directory for all templates available.
  """
  use ScsiteWeb, :html

  alias ScsiteWeb.ContactForm

  embed_templates "contact/*"
end
