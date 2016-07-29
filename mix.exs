defmodule Sudoku.Mixfile do
  use Mix.Project

  def project do
    [app: :sudoku,
     version: "0.1.0",
     name: "Sudoku",
     source_url: "https://bitbucket.org/BenNG/sudoku",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [ ex_doc: "~> 0.13.0",
      earmark: "~> 1.0"
    ]
  end
end
