# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ExceptionHandler

  def not_found
    render json: { error: 'not_found' }, status: :not_found
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      raise ExceptionHandler::RecordNotFound, e.message
    rescue JWT::DecodeError => e
      raise ExceptionHandler::DecodeError, e.message
    end
  end
end
