defmodule ExAliyun.OpenAPITest do
  use ExUnit.Case
  doctest ExAliyun.OpenAPI
  alias ExAliyun.OpenAPI.CodeUp
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

    test "produces deterministic signatures" do
      assert Utils.sign("key", "data") == Utils.sign("key", "data")
    end

    test "produces different signatures for different keys" do
      assert Utils.sign("key1", "data") != Utils.sign("key2", "data")
    end
  end

  describe "Utils.append_signature/3" do
    test "merges common_params and params" do
      common = %{"A" => "1"}
      params = %{"B" => "2"}
      secret = "test_secret"

      result = Utils.append_signature(common, params, secret)

      assert result["A"] == "1"
      assert result["B"] == "2"
    end

    test "includes Signature key" do
      result = Utils.append_signature(%{"A" => "1"}, %{"B" => "2"}, "secret")
      assert is_binary(result["Signature"])
      assert byte_size(result["Signature"]) > 0
    end

    test "overrides common_params with params" do
      result = Utils.append_signature(%{"A" => "1"}, %{"A" => "2"}, "secret")
      assert result["A"] == "2"
    end
  end

  describe "get_access_info/1" do
    setup do
      Application.put_env(:ex_aliyun_openapi, :test_service,
        access_key_id: "id",
        access_key_secret: "secret"
      )

      on_exit(fn -> Application.delete_env(:ex_aliyun_openapi, :test_service) end)
    end

    test "returns configured access info" do
      info = ExAliyun.OpenAPI.get_access_info(:test_service)
      assert info[:access_key_id] == "id"
      assert info[:access_key_secret] == "secret"
    end
  end

  describe "API call functions" do
    setup do
      env = %{
        cps: [access_key_id: "id", access_key_secret: "secret"],
        sts: [access_key_id: "id", access_key_secret: "secret"],
        sms: [access_key_id: "id", access_key_secret: "secret"],
        global_sms: [access_key_id: "id", access_key_secret: "secret"],
        captcha: [access_key_id: "id", access_key_secret: "secret"],
        codeup: [access_key_id: "id", access_key_secret: "secret"],
        geoip: [access_key_id: "id", access_key_secret: "secret"]
      }

      for {service, config} <- env do
        Application.put_env(:ex_aliyun_openapi, service, config)
      end

      :meck.new(Tesla)

      :meck.expect(Tesla, :client, fn middleware, adapter ->
        %Tesla.Client{pre: middleware, adapter: adapter}
      end)

      :meck.expect(Tesla, :post, fn _client, _url, _params -> {:ok, %{body: %{"ok" => true}}} end)

      on_exit(fn ->
        try do
          :meck.unload(Tesla)
        catch
          _, _ -> :ok
        end

        for {service, _config} <- env do
          Application.delete_env(:ex_aliyun_openapi, service)
        end
      end)
    end

    test "call_cps" do
      assert {:ok, %{body: %{"ok" => true}}} = ExAliyun.OpenAPI.call_cps(%{})
    end

    test "call_sts" do
      assert {:ok, %{body: %{"ok" => true}}} = ExAliyun.OpenAPI.call_sts(%{})
    end

    test "call_sms" do
      assert {:ok, %{body: %{"ok" => true}}} = ExAliyun.OpenAPI.call_sms(%{})
    end

    test "call_global_sms" do
      assert {:ok, %{body: %{"ok" => true}}} = ExAliyun.OpenAPI.call_global_sms(%{})
    end

    test "call_captcha" do
      assert {:ok, %{body: %{"ok" => true}}} = ExAliyun.OpenAPI.call_captcha(%{})
    end

    test "call_codeup" do
      assert {:ok, %{body: %{"ok" => true}}} = ExAliyun.OpenAPI.call_codeup(%{})
    end

    test "call_geoip" do
      assert {:ok, %{body: %{"ok" => true}}} = ExAliyun.OpenAPI.call_geoip(%{})
    end

    test "CodeUp.call_task calls call_codeup" do
      assert {:ok, %{body: %{"ok" => true}}} = CodeUp.call_task(%{"foo" => "bar"})
    end

    test "CodeUp.call_project calls call_codeup" do
      assert {:ok, %{body: %{"ok" => true}}} = CodeUp.call_project(%{"foo" => "bar"})
    end
  end
end
