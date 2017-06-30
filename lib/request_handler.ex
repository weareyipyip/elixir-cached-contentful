defmodule CachedContentful.RequestHandler do 

	@space_id Application.get_env(:cached_contentful, :space_id)
	@access_token Application.get_env(:cached_contentful, :access_token)
	@base_url "https://cdn.contentful.com"

	def get_all_entries() do
		url = "#{@base_url}/spaces/#{@space_id}/entries?access_token=#{@access_token}"
		case HTTPoison.get!(url) do
			%HTTPoison.Response{status_code: 200, body: body} ->
				items = body |> Poison.decode!
				items["items"]
		end
	end

end