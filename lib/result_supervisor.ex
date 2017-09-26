defmodule CachedContentful.ResultSupervisor do
	
	use Supervisor

	def start_link do
		Supervisor.start_link(__MODULE__, [], name: :result_supervisor)
	end

	def start_room(name) do
		Supervisor.start_child(:result_supervisor, [name])
	end

	def init(_) do
		children = [
			worker(CachedContentful.CustomRegistry, [])
		]

		supervise(children, strategy: :simple_one_for_one)
	end

end