require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  setup do
    @project = projects(:one)
    @task = tasks(:one)
  end

  test "should get index" do
    get :index, :project_id => @project
    assert_response :success
    assert_not_nil assigns(:tasks)
  end

  test "should get new" do
    get :new, :project_id => @project
    assert_response :success
  end

  test "should create task" do
    assert_difference('Task.count') do
      post :create, :project_id => @project, :task => @task.attributes
    end

    assert_redirected_to project_task_path(@project, assigns(:task))
  end

  test "should show task" do
    get :show, :project_id => @project, :id => @task.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :project_id => @project, :id => @task.to_param
    assert_response :success
  end

  test "should update task" do
    put :update, :project_id => @project, :id => @task.to_param, :task => @task.attributes
    assert_redirected_to project_task_path(@project, assigns(:task))
  end

  test "should destroy task" do
    assert_difference('Task.count', -1) do
      delete :destroy, :project_id => @project, :id => @task.to_param
    end

    assert_redirected_to project_tasks_path(@project)
  end
end
