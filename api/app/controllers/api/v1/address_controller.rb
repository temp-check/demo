module Api
  module V1
    class AddressController < BaseController
      def search
        @location = Location.find_or_create_by(address: params[:q])
        if @location.errors.any? || !@location.geocode_error.nil?
          errors = @location.errors.full_messages + [@location.geocode_error]
          render errors: errors, status: :unprocessable_entity
        else
          render json: @location.as_json(include: { postal_code: { include: :temperature } }), status: :ok
          @location&.postal_code&.temperature&.update_attribute(:cached, true)
        end
      end
    end
  end
end
