defmodule ScsiteWeb.ContactForm do
  use Phoenix.Component

  use Phoenix.VerifiedRoutes,
    router: ScsiteWeb.Router,
    endpoint: ScsiteWeb.Endpoint

  alias ScsiteWeb.CoreComponents, as: CComp

  def form(assigns) do
    assigns = assigns |> update(:form, &to_form(&1))

    ~H"""
    <div>
      <h3>Contact</h3>
      <CComp.simple_form for={@form} method="post" action={~p"/contact"}>
        <CComp.input field={@form[:email]} type="email" label="Email"/>
        <CComp.input field={@form[:message]} type="textarea" label="Message" rows="5" />
        <:actions>
          <CComp.button>Save</CComp.button>
        </:actions>
      </CComp.simple_form>
    </div>
    """
  end
end
