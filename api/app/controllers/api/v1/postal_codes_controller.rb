module Api
  module V1
    class PostalCodesController < BaseController
      before_action :set_postal_code, only: %i[ show update destroy ]

      # GET /api/v1/postal_codes
      def index
        @postal_codes = PostalCode.all

        render json: @postal_codes
      end

      # GET /api/v1/postal_codes/:id
      def show
        render json: @postal_code
      end

      # POST /api/v1/postal_codes
      def create
        @postal_code = PostalCode.new(postal_code_params)

        if @postal_code.save
          render json: @postal_code, status: :created, location: api_v1_postal_code_url(@postal_code)
        else
          render json: @postal_code.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/postal_codes/:id
      def update
        if @postal_code.update(postal_code_params)
          render json: api_v1_postal_code_url(@postal_code)
        else
          render json: @postal_code.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/postal_codes/:id
      def destroy
        @postal_code.destroy!
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_postal_code
          @postal_code = PostalCode.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def postal_code_params
          params.require(:postal_code).permit(:code)
        end
    end
  end
end