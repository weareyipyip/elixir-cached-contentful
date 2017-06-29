defmodule CachedContentful.RequestHandler do 

	@space_id Application.get_env(:cached_contentful, :space_id)
	@access_token Application.get_env(:cached_contentful, :access_token)

	def get_all_entries() do
		Contentful.Delivery.entries(@space_id, @access_token)
	end

end