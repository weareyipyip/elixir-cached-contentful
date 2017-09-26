defmodule CachedContentful.CustomRegistry do 

	use GenServer

	def start_link(name) do
		GenServer.start_link(__MODULE__, [], name: via_tuple(name))
	end

	defp via_tuple(result_name) do
		{:via, :gproc, {:n, :l, {:result, result_name}}}
	end

	# API

	def add_result(result_name, result) do
		GenServer.cast(via_tuple(result_name), {:add_result, result})
	end

	def get_results(result_name) do
		case GenServer.whereis(via_tuple(result_name)) do
			nil ->
				CachedContentful.ResultSupervisor.start_room(result_name)
				GenServer.call(via_tuple(result_name), :get_results)
			server ->
				GenServer.call(server, :get_results)
		end		
	end

	# Server
	def init(results) do
		{:ok, results}
	end

	def handle_cast({:add_result, new_result}, results) do
		{:noreply, [new_result]}
	end

	def handle_call(:get_results, _from, results) do
		{:reply, results, results}
	end

end