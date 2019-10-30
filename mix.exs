defmodule CachedContentful.Mixfile do
  use Mix.Project

  def project do
    [
      app: :cached_contentful,
      version: "0.5.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {CachedContentful.Application, []},
      extra_applications: [:logger, :httpoison]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:poison, "~> 3.1"},
      {:httpoison, "~> 1.0"},
      {:gproc, "~> 0.6.1"}
    ]
  end
end
