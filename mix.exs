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
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp description() do
    "A simple linear function solver.  Define a system of equations, solve them in any direction."
  end

  defp package() do
    [
      name: "Solver",
      files: ~w(lib .formatter.exs license* mix.exs README*),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/rjo1970/solver"}
    ]
  end
end
