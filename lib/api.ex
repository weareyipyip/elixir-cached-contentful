defmodule CachedContentful.Api do 

	alias CachedContentful.RequestHandler

	# ENTRIES
	def getEntries do
		GenServer.call(CachedContentful.EntryRegistry, :getEntries)
	end

	def getEntriesByType(type) do
		GenServer.call(CachedContentful.EntryRegistry, :getEntries)
			|> Enum.map(fn(entry) ->
			if entry["sys"]["contentType"]["sys"]["id"] == type do
				entry
			end
		end)
			|> Enum.filter(fn(entry) -> entry != nil end)
	end

	def getEntryById(id) do
		GenServer.call(CachedContentful.EntryRegistry, :getEntries)
			|> Enum.map(fn(entry) ->
			if entry["sys"]["id"] == id do
				entry
			end
		end)
			|> Enum.filter(fn(entry) -> entry != nil end)
			|> List.first
	end

	def customEntrySearch(queryName, queryMap \\ %{}, update \\ false) do
		case CachedContentful.CustomRegistry.get_results(queryName) do
			[] -> 
				fetchCustomData(queryName, queryMap)
			results ->
				if update do
					fetchCustomData(queryName, queryMap)
				else
					results |> List.first()
				end
		end
	end

	defp fetchCustomData(queryName, queryMap) do
		query = Enum.map(queryMap, fn({k, v}) -> 
				"&#{k}=#{v}"
			end)
			|> List.to_string

		results = CachedContentful.RequestHandler.custom_query(query)
		CachedContentful.CustomRegistry.add_result(queryName, results)
		results
	end

	# ASSETS
	def getAssets do
		GenServer.call(CachedContentful.AssetRegistry, :getAssets)
	end

	def getAssetById(id) do
		GenServer.call(CachedContentful.AssetRegistry, :getAssets)
			|> Enum.map(fn(asset) ->
			if asset["sys"]["id"] == id do
				asset
			end
		end)
			|> Enum.filter(fn(asset) -> asset != nil end)
			|> List.first
	end



	# UPDATERS
	def updateEntries do
		entries = RequestHandler.get_all_entries()
		GenServer.cast(CachedContentful.EntryRegistry, {:updateEntries, entries})
	end

	def updateAssets do
		assets = RequestHandler.get_all_assets()
		GenServer.cast(CachedContentful.AssetRegistry, {:updateAssets, assets})
	end

end