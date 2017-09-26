defmodule CachedContentful.EntryRegistry do 
	use GenServer
	require Logger

	alias CachedContentful.RequestHandler

	@auto_update Application.get_env(:cached_contentful, :auto_update, false)
	@update_interval Application.get_env(:cached_contentful, :update_interval, 1 * 60 * 60 * 10000)

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
		Process.send_after(self(), :work, @update_interval)
	end

	def handle_info(:work, state) do 
    	entries = RequestHandler.get_all_entries()
		GenServer.cast(__MODULE__, {:updateEntries, entries})
    	schedule_work()
	    {:noreply, state}
	 end

	# Getters
	def handle_call(:getEntries, _from, entryData) do
		case entryData do
			entries -> 
				{:reply, entries, entries}
			# {:error, nil} -> 
			# 	{:reply, %{}, {:error, nil}}
		end
	end

	# Updates
	def handle_cast({:updateEntries, entries}, _entryData) do
		{:noreply, entries}
	end

end