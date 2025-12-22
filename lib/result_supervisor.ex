defmodule CachedContentful.ResultSupervisor do
  use DynamicSupervisor

  def start_link(init_arg) do
    DynamicSupervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  def start_room(name) do
    DynamicSupervisor.start_child(__MODULE__, {CachedContentful.CustomRegistry, name})
  end

  def init(_) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end
