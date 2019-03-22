defmodule CachedContentful.AssetRegistry do 
	use GenServer
	require Logger

	alias CachedContentful.RequestHandler

	defp get_env_auto_update(), do: Application.get_env(:cached_contentful, :auto_update, false)
	defp get_env_update_interval(), do: Application.get_env(:cached_contentful, :update_interval, 1 * 60 * 60 * 10000)

	def start_link(name) do
		GenServer.start_link(__MODULE__, :ok, name: name)
	end

	def init(:ok) do
		if get_env_auto_update(), do: schedule_work()
		entryData = RequestHandler.get_all_assets()
		{:ok, entryData}
	end

	# Auto updater
	defp schedule_work do
		Process.send_after(self(), :work, get_env_update_interval())
	end

	def handle_info(:work, state) do 
    	assets = RequestHandler.get_all_assets()
		GenServer.cast(__MODULE__, {:updateAssets, assets})
    	schedule_work()
	    {:noreply, state}
	 end

	# Getters
	def handle_call(:getAssets, _from, assetData) do
		case assetData do
			assets -> 
				{:reply, assets, assets}
			# {:error, nil} -> 
			# 	{:reply, %{}, {:error, nil}}
		end
	end

	# Updates
	def handle_cast({:updateAssets, assets}, _assetData) do
		{:noreply, assets}
	end

end