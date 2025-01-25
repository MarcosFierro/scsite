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
      <h2 class="text-3xl font-medium text-blue-600">Contacto</h2>
      <CComp.simple_form for={@form} method="post" action={~p"/contact"}>
        <CComp.input field={@form[:name]} type="text" label="Nombre *" minlength="3" required/>
        <CComp.input field={@form[:email]} type="email" label="Email *" required/>
        <CComp.input field={@form[:phone]} type="text" label="Teléfono" minlength="8" maxlength="13"/>
        <CComp.input field={@form[:message]} type="textarea" label="Mensaje" rows="5" maxlength="600"/>
        <:actions>
          <CComp.button>Enviar</CComp.button>
        </:actions>
      </CComp.simple_form>
    </div>
    """
  end
end
