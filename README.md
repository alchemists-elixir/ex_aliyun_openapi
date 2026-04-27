# ExAliyun.OpenAPI

> [中文文档](README_CN.md)

[![Module Version](https://img.shields.io/hexpm/v/ex_aliyun_openapi.svg)](https://hex.pm/packages/ex_aliyun_openapi)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/ex_aliyun_openapi/)
[![Total Download](https://img.shields.io/hexpm/dt/ex_aliyun_openapi.svg)](https://hex.pm/packages/ex_aliyun_openapi)
[![Last Updated](https://img.shields.io/github/last-commit/alchemists-elixir/ex_aliyun_openapi/master.svg)](https://github.com/alchemists-elixir/ex_aliyun_openapi/commits/master)
[![CI](https://github.com/alchemists-elixir/ex_aliyun_openapi/actions/workflows/ci.yml/badge.svg)](https://github.com/alchemists-elixir/ex_aliyun_openapi/actions/workflows/ci.yml)
[![Coverage Status](https://coveralls.io/repos/github/alchemists-elixir/ex_aliyun_openapi/badge.svg?branch=master)](https://coveralls.io/github/alchemists-elixir/ex_aliyun_openapi?branch=master)

## Description

ExAliyun.OpenAPI provides Elixir clients for Aliyun (Alibaba Cloud) OpenAPI services:

* [CPS](https://help.aliyun.com/document_detail/48038.html) (Cloud Push Service)
* [STS](https://help.aliyun.com/document_detail/28763.html) (Security Token Service)
* [SMS](https://help.aliyun.com/document_detail/101414.html) (Short Message Service)
* [AFS](https://help.aliyun.com/document_detail/66340.html) (Anti-Fraud Service / Human Verification)
* [CodeUp](https://next.api.aliyun.com/product/devops-rdc) (DevOps Project Management)
* [GeoIP](https://help.aliyun.com/document_detail/170546.html) (IP Geolocation)

## Installation

Add `ex_aliyun_openapi` to your `mix.exs`:

```elixir
def deps do
  [
    {:ex_aliyun_openapi, "~> 0.9"}
  ]
end
```

## Requirements

* Elixir 1.18+
* Erlang/OTP 27+

## Configuration

Configure your Aliyun credentials per service:

```elixir
config :ex_aliyun_openapi, :cps,
  access_key_id: "YOUR ACCESS KEY ID",
  access_key_secret: "YOUR ACCESS KEY SECRET"

config :ex_aliyun_openapi, :sts,
  access_key_id: "YOUR ACCESS KEY ID",
  access_key_secret: "YOUR ACCESS KEY SECRET"
```

Supported service keys: `:cps`, `:sts`, `:sms`, `:global_sms`, `:afs`, `:codeup`, `:geoip`

## Usage

Find the API parameters at [Aliyun API Reference](https://help.aliyun.com), then call the corresponding function:

```elixir
# STS - AssumeRole
params = %{
  "Action" => "AssumeRole",
  "RoleArn" => "acs:ram::1234567890:role/your-role",
  "RoleSessionName" => "default",
  "DurationSeconds" => 3600
}
ExAliyun.OpenAPI.call_sts(params)

# Alternatively, pass credentials inline:
ExAliyun.OpenAPI.call_sts(params, access_key_id: "ID", access_key_secret: "SECRET")
```

```elixir
# CPS - Push Notification
params = %{
  "Action" => "PushNoticeToAndroid",
  "AppKey" => "YOUR_APP_KEY",
  "Target" => "DEVICE",
  "TargetValue" => "YOUR_DEVICE_ID",
  "Title" => "Test Title",
  "Body" => "Hello, this is the notice body"
}
ExAliyun.OpenAPI.call_cps(params)
```

```elixir
# CodeUp - Create Task
ExAliyun.OpenAPI.CodeUp.call_task(%{
  "Action" => "CreateDevopsProjectTask",
  "OrgId" => "your_org_id",
  "ProjectId" => "your_project_id",
  "Content" => "Task content"
})
```

## CI Pipeline

This project includes a `mix ci` alias that runs:

1. `compile --all-warnings --warnings-as-errors`
2. `format --check-formatted`
3. `credo --strict`
4. `deps.unlock --check-unused`
5. `deps.audit`
6. `test --exclude external`
7. `xref graph --label compile-connected --fail-above 0`

## Contributing

To add support for new Aliyun services:

1. Add a new `call_<service>` function in `lib/ex_aliyun_openapi.ex`
2. Add corresponding tests
3. Submit a pull request

## License

MIT
