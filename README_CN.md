# ExAliyun.OpenAPI

> [English Documentation](README.md)

[![Module Version](https://img.shields.io/hexpm/v/ex_aliyun_openapi.svg)](https://hex.pm/packages/ex_aliyun_openapi)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/ex_aliyun_openapi/)
[![Total Download](https://img.shields.io/hexpm/dt/ex_aliyun_openapi.svg)](https://hex.pm/packages/ex_aliyun_openapi)
[![Last Updated](https://img.shields.io/github/last-commit/alchemists-elixir/ex_aliyun_openapi/master.svg)](https://github.com/alchemists-elixir/ex_aliyun_openapi/commits/master)
[![CI](https://github.com/alchemists-elixir/ex_aliyun_openapi/actions/workflows/ci.yml/badge.svg)](https://github.com/alchemists-elixir/ex_aliyun_openapi/actions/workflows/ci.yml)
[![Coverage Status](https://coveralls.io/repos/github/alchemists-elixir/ex_aliyun_openapi/badge.svg?branch=master)](https://coveralls.io/github/alchemists-elixir/ex_aliyun_openapi?branch=master)

## 简介

ExAliyun.OpenAPI 为阿里云 OpenAPI 提供 Elixir 客户端，支持以下服务：

* [CPS](https://help.aliyun.com/document_detail/48038.html)（移动推送服务）
* [STS](https://help.aliyun.com/document_detail/28763.html)（短期访问权限管理）
* [SMS](https://help.aliyun.com/document_detail/101414.html)（短信服务）
* [Captcha](https://help.aliyun.com/zh/captcha/captcha2-0/user-guide/server-access)（验证码2.0）
* [CodeUp](https://next.api.aliyun.com/product/devops-rdc)（云效任务管理）
* [GeoIP](https://help.aliyun.com/document_detail/170546.html)（查询 IP 地理位置）

## 安装

在 `mix.exs` 中添加依赖：

```elixir
def deps do
  [
    {:ex_aliyun_openapi, "~> 1.0"}
  ]
end
```

## 环境要求

* Elixir 1.18+
* Erlang/OTP 27+

## 配置

按服务配置你的阿里云访问凭证：

```elixir
config :ex_aliyun_openapi, :cps,
  access_key_id: "你的 AccessKey ID",
  access_key_secret: "你的 AccessKey Secret"

config :ex_aliyun_openapi, :sts,
  access_key_id: "你的 AccessKey ID",
  access_key_secret: "你的 AccessKey Secret"
```

支持的服务键：`:cps`、`:sts`、`:sms`、`:global_sms`、`:captcha`、`:codeup`、`:geoip`

## 使用

在 [阿里云 API 文档](https://help.aliyun.com) 中找到接口参数，然后调用对应的函数：

```elixir
# STS - 角色扮演
params = %{
  "Action" => "AssumeRole",
  "RoleArn" => "acs:ram::1234567890:role/your-role",
  "RoleSessionName" => "default",
  "DurationSeconds" => 3600
}
ExAliyun.OpenAPI.call_sts(params)

# 也可以内联传入凭证：
ExAliyun.OpenAPI.call_sts(params, access_key_id: "ID", access_key_secret: "SECRET")
```

```elixir
# CPS - 推送通知
params = %{
  "Action" => "PushNoticeToAndroid",
  "AppKey" => "你的 AppKey",
  "Target" => "DEVICE",
  "TargetValue" => "你的设备 ID",
  "Title" => "测试标题",
  "Body" => "你好，这是通知内容"
}
ExAliyun.OpenAPI.call_cps(params)
```

```elixir
# CodeUp - 创建任务
ExAliyun.OpenAPI.CodeUp.call_task(%{
  "Action" => "CreateDevopsProjectTask",
  "OrgId" => "你的组织 ID",
  "ProjectId" => "你的项目 ID",
  "Content" => "任务内容"
})
```

## CI 流水线

本项目包含 `mix ci` 别名，依次执行：

1. `compile --all-warnings --warnings-as-errors`
2. `format --check-formatted`
3. `credo --strict`
4. `deps.unlock --check-unused`
5. `deps.audit`
6. `test --exclude external`
7. `xref graph --label compile-connected --fail-above 0`

## 贡献

添加新的阿里云服务支持：

1. 在 `lib/ex_aliyun_openapi.ex` 中添加新的 `call_<service>` 函数
2. 添加对应的测试
3. 提交 Pull Request

## 许可证

MIT
