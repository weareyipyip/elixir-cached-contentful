defmodule CachedContentful.Api do 

	alias CachedContentful.RequestHandler

	@module CachedContentful.ContentfulRegistry

	# GETTERS
	def getEntries do
		GenServer.call(@module, :getEntries)
	end

	def getEntriesByType(type) do
		entries = GenServer.call(@module, :getEntries)
			|> Enum.map(fn(entry) ->
			if entry["sys"]["contentType"]["sys"]["id"] == type do
				entry
			end
		end)
			|> Enum.filter(fn(entry) -> entry != nil end)
	end

	def getEntryById(id) do
		entries = GenServer.call(@module, :getEntries)
			|> Enum.map(fn(entry) ->
			if entry["sys"]["id"] == id do
				entry
			end
		end)
			|> Enum.filter(fn(entry) -> entry != nil end)
			|> List.first
	end

	# UPDATERS
	def updateEntries do
		entries = RequestHandler.get_all_entries()
		GenServer.cast(@module, {:updateEntries, entries})
	end

end