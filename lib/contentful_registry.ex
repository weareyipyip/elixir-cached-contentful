defmodule CachedContentful.ContentfulRegistry do 
	use GenServer
	require Logger

	alias CachedContentful.RequestHandler

	@auto_update Application.get_env(:cached_contentful, :auto_update)
	@update_interval Application.get_env(:cached_contentful, :update_interval)


	def start_link(name) do
		GenServer.start_link(__MODULE__, :ok, name: name)
	end

	def init(:ok) do
		if @auto_update, do: schedule_work()
		entryData = RequestHandler.get_all_entries()
		{:ok, entryData}
	end

	# Auto updater
	defp schedule_work do
		update_interval = if @update_interval do
			@update_interval
		else
			1 * 60 * 60 * 1000
		end
		Process.send_after(self(), :work, update_interval)
	end

	def handle_info(:work, state) do
    	updateEntries()
    	schedule_work()
	    {:noreply, state}
	 end

	# Get saved entries
	def getEntries() do
		GenServer.call(__MODULE__, :getEntries)
	end

	def handle_call(:getEntries, _from, entryData) do
		# Contentful gives its error in the request, so need to find another wat to handle it
		case entryData do
			entries -> 
				{:reply, entries, entries}
			# {:error, nil} -> 
			# 	{:reply, %{}, {:error, nil}}
		end
	end

	# Update entries
	def updateEntries() do
		entries = RequestHandler.get_all_entries()
		GenServer.cast(__MODULE__, {:updateEntries, entries})
	end

	def handle_cast({:updateEntries, entries}, _entryData) do
		{:noreply, entries}
	end

end