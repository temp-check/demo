require "test_helper"

class TemperaturesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @temperature = temperatures(:one)
  end

  test "should get index" do
    get api_v1_temperatures_url, as: :json
    assert_response :success
  end

  # test "should create temperature" do
  #   assert_difference("Temperature.count") do
  #     post api_v1_temperatures_url, params: { temperature: { forecast: @temperature.forecast, postal_code_id: @temperature.postal_code_id } }, as: :json
  #   end

  #   assert_response :created
  # end

  test "should show temperature" do
    get api_v1_temperature_url(@temperature), as: :json
    assert_response :success
  end

  test "should update temperature" do
    patch api_v1_temperature_url(@temperature), params: { temperature: { forecast: @temperature.forecast, postal_code_id: @temperature.postal_code_id } }, as: :json
    assert_response :success
  end

  test "should destroy temperature" do
    assert_difference("Temperature.count", -1) do
      delete api_v1_temperature_url(@temperature), as: :json
    end

    assert_response :no_content
  end
end
