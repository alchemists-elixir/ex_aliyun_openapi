defmodule ExAliyun.OpenAPI.CodeUp do
  @moduledoc """
  Convenience module for Aliyun CodeUp (云效) API calls.
  """

  def call_task(params, access_info \\ nil),
    do: ExAliyun.OpenAPI.call_codeup(params, access_info)

  def call_project(params, access_info \\ nil),
    do: ExAliyun.OpenAPI.call_codeup(params, access_info)
end
