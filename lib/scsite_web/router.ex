defmodule ScsiteWeb.Router do
  use ScsiteWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :redirect_apex_to_www
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ScsiteWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  # pipeline :api do
  #   plug :accepts, ["json"]
  # end

  defp redirect_apex_to_www(conn, _opts) do
    if conn.host == "softwarecircular.com" do
      conn
      |> Phoenix.Controller.redirect(external: "https://www.#{conn.host}#{conn.request_path}")
      |> halt()
    else
      conn
    end
  end

  scope "/", ScsiteWeb do
    pipe_through :browser


    get "/", HomeController, :home
    get "/faqs", HomeController, :faqs
    get "/pricing", HomeController, :pricing
    get "/contact", ContactController, :new
    post "/contact", ContactController, :submit
  end

  # Other scopes may use custom stacks.
  # scope "/api", ScsiteWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:scsite, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ScsiteWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
