defmodule DYPA01.MixProject do
  use Mix.Project

  @version "0.1.2"
  @source_url "https://github.com/mnishiguchi/dypa01"

  def project do
    [
      app: :dypa01,
      version: @version,
      description: "Use DYP-A01 ultrasonic distance sensor in Elixir",
      elixir: "~> 1.11",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      aliases: [],
      dialyzer: dialyzer(),
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {DYPA01.Application, []}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:circuits_uart, "~> 1.4"},
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.1", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.24", only: [:dev], runtime: false},
      {:mix_test_watch, "~> 1.0", only: :dev, runtime: false},
      {:mox, "~> 1.0", only: :test}
    ]
  end

  defp dialyzer() do
    [
      flags: [:race_conditions, :unmatched_returns, :error_handling, :underspecs]
    ]
  end

  defp docs do
    [
      extras: ["README.md"],
      source_ref: "v#{@version}",
      source_url: @source_url
    ]
  end

  defp package do
    %{
      files: [
        "lib",
        "mix.exs",
        "README.md",
        "LICENSE*",
        "CHANGELOG*"
      ],
      licenses: ["MIT"],
      links: %{
        "GitHub" => @source_url,
        "Data sheet" => "https://cdn-shop.adafruit.com/product-files/4664/4664_datasheet.pdf"
      }
    }
  end
end
