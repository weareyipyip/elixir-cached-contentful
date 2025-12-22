defmodule CachedContentful.Application do
 use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_, _) do
    children = [
      {CachedContentful.EntryRegistry, CachedContentful.EntryRegistry},
      {CachedContentful.AssetRegistry, CachedContentful.AssetRegistry},
      {CachedContentful.ResultSupervisor, []}
    ]

    opts = [strategy: :one_for_one, name: CachedContentful.Supervisor]
    Supervisor.start_link(children, opts)
  end

end
