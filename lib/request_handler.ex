defmodule CachedContentful.RequestHandler do 

	defp get_env_space_id(), do: Application.get_env(:cached_contentful, :space_id)
	defp get_env_access_token(), do: Application.get_env(:cached_contentful, :access_token)

	@base_url "https://cdn.contentful.com"

	def get_all_entries() do
		space_id = get_env_space_id()
		access_token = get_env_access_token()
		url = "#{@base_url}/spaces/#{space_id}/entries?access_token=#{access_token}&locale=*&limit=900"
		process_request(url)
	end

	def get_all_assets() do
		space_id = get_env_space_id()
		access_token = get_env_access_token()
		url = "#{@base_url}/spaces/#{space_id}/assets?access_token=#{access_token}&limit=900"
		process_request(url)
	end

	def custom_query(query) do
		space_id = get_env_space_id()
		access_token = get_env_access_token()
		url = "#{@base_url}/spaces/#{space_id}/entries?access_token=#{access_token}&locale=*#{query}&limit=900"
		process_request(url)
	end

	defp process_request(url) do
		case HTTPoison.get!(url) do
			%HTTPoison.Response{status_code: 200, body: body} ->
				items = body |> Poison.decode!
				items["items"]
			%HTTPoison.Response{status_code: 401, body: body} ->
				errors = body |> Poison.decode!
				IO.inspect errors
				{:error, errors}
		end
	end

end