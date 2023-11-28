module Api
  module V1
    class TemperaturesController < BaseController
      before_action :set_temperature, only: %i[ show update destroy ]

      # GET /api/v1/temperatures
      def index
        @temperatures = Temperature.all

        render json: @temperatures
      end

      # GET /api/v1/temperatures/:id
      def show
        render json: @temperature
      end

      # POST /api/v1/temperatures
      def create
        @temperature = Temperature.new(temperature_params)

        if @temperature.save
          render json: @temperature, status: :created, location: api_v1_temperature_url(@temperature)
        else
          render json: @temperature.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/temperatures/:id
      def update
        if @temperature.update(temperature_params)
          render json: @temperature
        else
          render json: @temperature.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/temperatures/:id
      def destroy
        @temperature.destroy!
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_temperature
          @temperature = Temperature.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def temperature_params
          params.require(:temperature).permit(:forecast, :postal_code_id)
        end
    end
  end
end