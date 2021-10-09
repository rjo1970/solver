defmodule Solver.MixProject do
  use Mix.Project

  def project do
    [
      app: :solver,
      name: "Solver",
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  defp description() do
    "A simple linear function solver.  Define a system of equations, solve them in any direction."
  end

  defp package() do
    [
      name: "Solver",
      files: ~w(lib priv .formatter.exs license* mix.exs README*),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/rjo1970/solver"}
    ]
  end
end
