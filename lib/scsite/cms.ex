defmodule Scsite.CMS do
  @api_url "https://cdn.contentful.com/spaces/k20aw75e7bk4/environments/master"
  @auth_token System.get_env("CONTENTFUL_ACCESS_TOKEN")

  def cmsTeslaClient do
    Tesla.client([
      Tesla.Middleware.JSON,
      {Tesla.Middleware.BaseUrl, @api_url},
      {Tesla.Middleware.BearerAuth, token: @auth_token}
    ])
  end

  def get_home_page_content do
    Tesla.get(cmsTeslaClient(), "/entries", query: [content_type: "scMarketing"])
    |> handle_response()
  end

  defp handle_response({:ok, %Tesla.Env{status: 200, body: body}}) do
    {:ok, Jason.decode!(body)}
  end

  defp handle_response({:ok, %Tesla.Env{status: status}}) do
    {:error, "Request failed with status: #{status}"}
  end

  defp handle_response({:error, reason}), do: {:error, reason}
end


# includes - Asset
#            Entry

# items - fields - campo o referencia(s)
#         meta
#         sys

# referencia:
#         sys - Id
#               ====>  includes - Entry - LOOK FOR sys,id == Id

# archivo media:
#         sys - Id
#               ====>  includes - Asset - LOOK FOR sys,id == Id
