module ExceptionHandler
  extend ActiveSupport::Concern

  class DecodeError < StandardError; end
  class ExpiredSignature < StandardError; end
  class AccessDenied < StandardError; end
  class RecordNotFound < StandardError; end
  class RecordInvalid < StandardError; end

  included do
    rescue_from ExceptionHandler::DecodeError do |e|
      render json: {
        message: e.message
      }, status: :unauthorized
    end

    rescue_from ExceptionHandler::ExpiredSignature do |e|
      render json: {
        message: e.message
      }, status: :unauthorized
    end
    
    rescue_from ExceptionHandler::RecordNotFound do |e|
      render json: {
        message: e.message
      }, status: :not_found
    end

    rescue_from ExceptionHandler::RecordInvalid do |e|
      render json: {
        message: e.message
      }, status: :unprocessable_entity
    end

    rescue_from ExceptionHandler::AccessDenied do |e|
      render json: {
        message: e.message
      }, status: :unauthorized
    end
  end
end
