defmodule MapDiff.Mixfile do
  use Mix.Project

  def project do
    [
      app: :map_diff,
      version: "0.1.0",
      elixir: "~> 1.4",
      package: package(),
      description: description(),
      source_url: "https://github.com/jessiahr/map_diff",
      name: "MapDiff",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:poison, "~> 3.1"}
    ]
  end

  defp description do
    """
    Generate deltas from two maps.
    """
  end

  defp package do
    # These are the default files included in the package
    [
      name: :map_diff,
      files: ["lib", "priv/static", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Jessiah Ratliff"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/jessiahr/map_diff"}
    ]
  end
end
