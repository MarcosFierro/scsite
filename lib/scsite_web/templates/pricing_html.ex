defmodule ScsiteWeb.PricingHTML do
  @moduledoc """
  See the `/templates/pricing` directory for all templates available.
  """
  use ScsiteWeb, :html

  alias ScsiteWeb.ContactForm

  embed_templates "pricing/*"
end
