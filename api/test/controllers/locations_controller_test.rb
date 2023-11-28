require "test_helper"

class LocationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @location = locations([:one, :two].sample)
    @location.address = "#{(1...700).to_a.sample} market St SF, CA"
  end

  test "should get index" do
    get api_v1_locations_url, as: :json
    assert_response :success
  end

  test "should create location" do
    assert_difference("Location.count") do
      post api_v1_locations_url, params: { location: { address: @location.address } }, as: :json
    end

    assert_response :created
  end

  test "should show location" do
    get api_v1_location_url(@location), as: :json
    assert_response :success
  end

  test "should update location" do
    patch api_v1_location_url(@location), params: { location: { address: @location.address } }, as: :json
    assert_response :success
  end

  test "should destroy location" do
    assert_difference("Location.count", -1) do
      delete api_v1_location_url(@location), as: :json
    end

    assert_response :no_content
  end

  test "should save invalid address with error code 404" do
    @invalid_address = locations(:invalid_address)
    assert_difference("Location.count") do
      post api_v1_locations_url, params: { location: { address: Faker::Address.full_address } }, as: :json
    end

    assert_equal Location::GEOCODER_ADDRESS_NOT_FOUND, Location.last.geocode_error
  end

  test "should save only unique invalid addresses with error code 404" do
    @invalid_address = locations(:invalid_address)
    assert_difference("Location.count") do
      post api_v1_locations_url, params: { location: { address: Faker::Address.full_address } }, as: :json
    end

    assert_equal Location::GEOCODER_ADDRESS_NOT_FOUND, Location.last.geocode_error
  end
end
