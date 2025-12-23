defmodule CachedContentful.Mixfile do
  use Mix.Project

  def project do
    [
      app: :cached_contentful,
      version: "1.0.0",
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
      {:poison, "~> 6.0"},
      {:httpoison, "~> 2.3"},
      {:gproc, "~> 1.0.0"}
    ]
  end
end
