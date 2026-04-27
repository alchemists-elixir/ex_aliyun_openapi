defmodule ExAliyunGeoIpTest do
  use ExUnit.Case
  doctest ExAliyun.OpenAPI
  @moduletag :external

  test "geoip: Describe ipv4" do
    params = %{"Action" => "DescribeIpv4Location", "Ip" => "221.206.131.10"}
    assert {:ok, _} = ExAliyun.OpenAPI.call_geoip(params)
  end
end
