defmodule ExAliyun.OpenAPI.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_aliyun_openapi,
      version: "1.0.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls, minimum_coverage: 80],
      aliases: aliases(),
      deps: deps(),
      docs: [extras: ["README.md"]],
      description: "Aliyun OpenAPI for elixir",
      source_url: "https://github.com/edragonconnect/ex_aliyun_openapi",
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {ExAliyun.OpenAPI.Application, []},
      extra_applications: [:logger]
    ]
  end

  def cli do
    [preferred_envs: [ci: :test, coveralls: :test, "coveralls.html": :test]]
  end

  def package do
    [
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/alchemists-elixir/ex_aliyun_openapi"}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.40", only: :dev, runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:mix_audit, "~> 2.1", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.18", only: :test},
      {:meck, "~> 0.9", only: :test},
      {:tesla, "~> 1.17"},
      {:finch, "~> 0.21"},
      {:uniq, "~> 0.6"}
    ]
  end

  defp aliases do
    [
      ci: [
        "compile --all-warnings --warnings-as-errors",
        "format --check-formatted",
        "credo --strict",
        "deps.unlock --check-unused",
        "deps.audit",
        "test --exclude external",
        "xref graph --label compile-connected --fail-above 0"
      ]
    ]
  end
end
