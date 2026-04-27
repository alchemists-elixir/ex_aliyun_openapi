defmodule ExAliyun.OpenAPITest do
  use ExUnit.Case
  doctest ExAliyun.OpenAPI
  alias ExAliyun.OpenAPI.Utils

  describe "should_retry/1" do
    test "retries on timeout" do
      assert ExAliyun.OpenAPI.should_retry({:error, "timeout"})
    end

    test "retries on socket closed" do
      assert ExAliyun.OpenAPI.should_retry({:error, "socket closed"})
    end

    test "does not retry on ok" do
      refute ExAliyun.OpenAPI.should_retry({:ok, %{}})
    end

    test "does not retry on other errors" do
      refute ExAliyun.OpenAPI.should_retry({:error, "other"})
    end
  end

  describe "get_timestamp/0" do
    test "returns ISO8601 UTC timestamp" do
      ts = ExAliyun.OpenAPI.get_timestamp()
      assert String.match?(ts, ~r/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}Z$/)
    end
  end

  describe "Utils.format_string_to_sign/1" do
    test "formats params sorted with URL encoding" do
      params = %{"Version" => "2016-08-01", "Action" => "Push", "Format" => "JSON"}

      result = Utils.format_string_to_sign(params)

      assert String.starts_with?(result, "POST&%2F&")
    end

    test "includes all params in sorted order" do
      params = %{"B" => "2", "A" => "1"}

      result = Utils.format_string_to_sign(params)

      assert result =~ "A%3D1"
      assert result =~ "B%3D2"

      assert String.contains?(result, "A%3D1&B%3D2") ||
               String.contains?(result, "A%3D1%26B%3D2")
    end
  end

  describe "Utils.sign/2" do
    test "returns base64-encoded HMAC-SHA1" do
      result = Utils.sign("secret", "string_to_sign")
      assert is_binary(result)
      assert byte_size(result) > 0
    end
  end
end
