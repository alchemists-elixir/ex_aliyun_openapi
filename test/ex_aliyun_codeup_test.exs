defmodule ExAliyunCodeUpTest do
  use ExUnit.Case
  doctest ExAliyun.OpenAPI
  alias ExAliyun.OpenAPI.CodeUp
  @moduletag :external
  @orgid "your_orgid"

  test "task: ListDevopsScenarioFieldConfig" do
    params = %{
      "Action" => "ListDevopsScenarioFieldConfig",
      "OrgId" => @orgid,
      "ProjectId" => "project_id"
    }

    assert {:ok, _} = CodeUp.call_task(params)

    params = %{
      "Action" => "GetDevopsProjectTaskInfo",
      "OrgId" => @orgid,
      "TaskId" => "your_task_id"
    }

    assert {:ok, _} = CodeUp.call_task(params)
  end

  test "test:ListDevopsProjectTaskFlow" do
    params = %{
      "Action" => "ListDevopsProjectTaskFlow",
      "OrgId" => @orgid,
      "ProjectId" => "your_project_id"
    }

    assert {:ok, _} = CodeUp.call_task(params)
  end

  test "test:ListDevopsProjectTaskFlowStatus" do
    params = %{
      "Action" => "ListDevopsProjectTaskFlowStatus",
      "OrgId" => @orgid,
      "TaskFlowId" => "your_id "
    }

    assert {:ok, _} = CodeUp.call_task(params)
  end

  test "test:createtask" do
    ts = DateTime.utc_now() |> Calendar.strftime("%Y-%m-%dT%H:%M:%S")

    create_params = %{
      "Action" => "CreateDevopsProjectTask",
      "OrgId" => @orgid,
      "ProjectId" => "your_project_id",
      "ScenarioFieldConfigId" => "your_id",
      "ExecutorId" => "your_id",
      "TaskFlowStatusId" => "your_id",
      "TaskListId" => "your_id",
      "Content" => "自动创建需求" <> ts,
      "Visible" => "members"
    }

    assert {:ok, _} = CodeUp.call_task(create_params)
  end

  test "project: CreateDevopsProject" do
    # CREATE PROJECT
    create_params = %{
      "Action" => "CreateDevopsProject",
      "OrgId" => @orgid,
      "Name" => "测试项目",
      "Description" => "elixir 单元测试项目"
    }

    assert {:ok, %Tesla.Env{body: %{"Object" => projectid}}} =
             CodeUp.call_project(create_params)

    # GET PROJECT INFO
    get_params = %{
      "Action" => "GetDevopsProjectInfo",
      "OrgId" => @orgid,
      "ProjectId" => projectid
    }

    assert {:ok, _} = CodeUp.call_project(get_params)

    # DELETE PROJECT
    delete_params = %{
      "Action" => "DeleteDevopsProject",
      "OrgId" => @orgid,
      "ProjectId" => projectid
    }

    assert {:ok, _} = CodeUp.call_project(delete_params)
  end
end
