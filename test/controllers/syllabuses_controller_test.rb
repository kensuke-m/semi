require 'test_helper'

class SyllabusesControllerTest < ActionController::TestCase
  setup do
    @syllabus = syllabuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:syllabuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create syllabus" do
    assert_difference('Syllabus.count') do
      post :create, syllabus: { abstract: @syllabus.abstract, evaluationmethod: @syllabus.evaluationmethod, goal: @syllabus.goal, plan: @syllabus.plan, referencebook: @syllabus.referencebook, remarks: @syllabus.remarks, selectionmethod: @syllabus.selectionmethod, staff_id: @syllabus.staff_id, subject_id: @syllabus.subject_id, subtitle: @syllabus.subtitle, textbook: @syllabus.textbook }
    end

    assert_redirected_to syllabus_path(assigns(:syllabus))
  end

  test "should show syllabus" do
    get :show, id: @syllabus
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @syllabus
    assert_response :success
  end

  test "should update syllabus" do
    patch :update, id: @syllabus, syllabus: { abstract: @syllabus.abstract, evaluationmethod: @syllabus.evaluationmethod, goal: @syllabus.goal, plan: @syllabus.plan, referencebook: @syllabus.referencebook, remarks: @syllabus.remarks, selectionmethod: @syllabus.selectionmethod, staff_id: @syllabus.staff_id, subject_id: @syllabus.subject_id, subtitle: @syllabus.subtitle, textbook: @syllabus.textbook }
    assert_redirected_to syllabus_path(assigns(:syllabus))
  end

  test "should destroy syllabus" do
    assert_difference('Syllabus.count', -1) do
      delete :destroy, id: @syllabus
    end

    assert_redirected_to syllabuses_path
  end
end
