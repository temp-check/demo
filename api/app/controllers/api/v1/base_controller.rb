module Api
  module V1
    class BaseController < ApplicationController
      # protect_from_forgery with: :null_session

      def render(options = {})
        # Determine if it's an error response based on the presence of errors or the status code
        is_error_response = options.key?(:errors) || options[:status]&.to_s&.start_with?('4') || options[:status]&.to_s&.start_with?('5')

        # Format the response accordingly
        options = is_error_response ? format_error_response(options) : format_success_response(options)

        super(options)
      end

      private

      def format_error_response(options)
        errors = format_errors(options.delete(:errors) || options.delete(:json))
        { json: { data: {}, errors: errors }, status: options[:status] }
      end

      def format_success_response(options)
        data = options.delete(:json) || {}
        { json: { data: data, errors: [] }, status: options[:status] }
      end

      def format_errors(errors)
        if errors.respond_to?(:full_messages)
          # ActiveModel::Errors or similar structure
          errors.full_messages.map { |msg| { message: msg } }
        elsif errors.is_a?(Array)
          # Array of error messages
          errors.map { |msg| { message: msg } }
        else
          # Single error message or other formats
          [{ message: errors.to_s }]
        end
      end
    end
  end
end
