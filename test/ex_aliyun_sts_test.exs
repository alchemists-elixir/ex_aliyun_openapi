defmodule ExAliyunStsTest do
  use ExUnit.Case
  doctest ExAliyun.OpenAPI
  @moduletag :external

  test "sts: AssumeRole" do
    params = %{
      "Action" => "AssumeRole",
      "RoleArn" => "* Your role arn *",
      "RoleSessionName" => "default",
      "DurationSeconds" => 3600
    }

    assert {:ok, _} = ExAliyun.OpenAPI.call_sts(params)
  end

  test "sts: GetCallerIdentity" do
    params = %{
      "Action" => "GetCallerIdentity"
    }

    assert {:ok, _} = ExAliyun.OpenAPI.call_sts(params)
  end
end
