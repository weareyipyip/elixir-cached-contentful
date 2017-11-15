defmodule CachedContentful.Api do 

	alias CachedContentful.RequestHandler

	@default_language Application.get_env(:cached_contentful, :default_language)

	# ENTRIES
	def getEntries(locale) do
		GenServer.call(CachedContentful.EntryRegistry, :getEntries)
			|> Enum.map(fn(entry) ->				
				format_entry(entry, locale)
			end)
	end

	def getEntriesByType(type, locale) do
		GenServer.call(CachedContentful.EntryRegistry, :getEntries)
			|> Enum.map(fn(entry) ->
			if entry["sys"]["contentType"]["sys"]["id"] == type do
				format_entry(entry, locale)
			end
		end)
			|> Enum.filter(fn(entry) -> entry != nil end)
	end

	def getEntryById(id, locale) do
		GenServer.call(CachedContentful.EntryRegistry, :getEntries)
			|> Enum.map(fn(entry) ->
			if entry["sys"]["id"] == id do
				format_entry(entry, locale)
			end
		end)
			|> Enum.filter(fn(entry) -> entry != nil end)
			|> List.first
	end

	def customEntrySearch(queryName, queryMap \\ %{}, update \\ false, locale) do
		case CachedContentful.CustomRegistry.get_results(queryName) do
			[] -> 
				fetchCustomData(queryName, queryMap, locale)
			results ->
				if update do
					fetchCustomData(queryName, queryMap, locale)
						|> Enum.map(fn(entry) ->				
							format_entry(entry, locale)
						end)
				else
					results 
						|> List.first()
						|> Enum.map(fn(entry) ->				
							format_entry(entry, locale)
						end) 
						
				end
		end
	end

	defp fetchCustomData(queryName, queryMap, locale) do
		query = Enum.map(queryMap, fn({k, v}) -> 
				"&#{k}=#{v}"
			end)
			|> List.to_string

		results = CachedContentful.RequestHandler.custom_query(query)
		CachedContentful.CustomRegistry.add_result(queryName, results)
		results
	end

	defp format_entry(entry, locale) do
		fields = Enum.map(entry["fields"], fn({k, v}) -> 
			v = if Map.has_key?(v, locale) do
				v[locale]
			else
				v[@default_language]
			end
			%{ "#{k}" => v }
		end)
		%{
			type: entry["sys"]["contentType"]["sys"]["id"],
			id: entry["sys"]["id"],
			created_at: entry["sys"]["createdAt"],
			fields: fields
		}
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