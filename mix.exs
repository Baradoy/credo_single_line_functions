defmodule CredoSingleLineFunctions.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :credo_single_line_functions,
      version: @version,
      elixir: "~> 1.10",
      deps: deps(),
      description: description(),
      package: package(),
      source_url: "https://github.com/Baradoy/credo_single_line_functions",
      docs: docs()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.0"},
      {:ex_doc, "~> 0.22", only: :dev, runtime: false}
    ]
  end

  defp description() do
    """
    Single Line Function Checker for Credo
    """
  end

  defp package() do
    [
      maintainers: ["Graham Baradoy"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/Baradoy/credo_single_line_functions"}
    ]
  end

  defp docs() do
    [
      main: "readme",
      name: "CredoSingleLineFunctions",
      source_ref: "v#{@version}",
      canonical: "http://hexdocs.pm/credo_single_line_functions",
      source_url: "https://github.com/Baradoy/credo_single_line_functions",
      extras: [
        "README.md"
      ]
    ]
  end
end
