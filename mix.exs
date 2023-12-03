defmodule AOC2023.MixProject do
  use Mix.Project

  def project do
    [
      app: :aoc_2023,
      version: "0.1.0",
      elixir: "~> 1.15",
      deps: deps()
    ]
  end

  defp deps do
    [
      {:jason, "~> 1.4"}
    ]
  end
end
