defmodule Toglx.Mixfile do
  use Mix.Project

  def project do
    [app: :toglx,
     description: description,
     package: package,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     escript: [main_module: Toglx.Escript],
     deps: deps]
  end

  def application do
    [mod: {Toglx, []},
     applications: [:logger, :togglex]]
  end

  defp description do
    "Toggl(ex) time tracking client"
  end

  defp package do
    [maintainers: ["Kenny Ballou"],
     licenses: ["GPLv3"],
     links: %{"GitHub" => "https://github.com/kennyballou/toglx"},
     files: ~w(mix.exs README.md LICENSE lib)]
  end

  defp deps do
    [{:togglex, "~> 0.1"},
     {:argument_parser, "~> 0.1"},
     {:configparser_ex, "~> 0.2"}]
  end
end
