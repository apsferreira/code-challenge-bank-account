module Api::V1
  class AuthenticationsController < ApplicationController
    include ExceptionHandler
    before_action :authorize_request, except: [:login, :alive]

    # GET /api/v1/alive 
    def alive
      render json: {alive: "true"}, status: :ok
    end

    def set_admin
      if JsonWebToken.set_admin(request)
        render json: {confirmed: true}, status: :ok
      else
        raise ExceptionHandler::AccessDenied, 'token with problem'
      end
    end

    # POST /api/v1/auth/login
    def login
      @user = User.find_by_username(params[:username])
      if @user&.authenticate(params[:password])
        token = JsonWebToken.encode(user_id: @user.id, referral_code: @user.referral_code, is_admin: @user.is_admin)
        time = Time.now + 24.hours.to_i
        render json: {token: token, expiration: time.strftime("%m-%d-%Y %H:%M"),
                      username: @user.username}, status: :ok
      else
        raise ExceptionHandler::AccessDenied, 'user or password with error'
      end
    end

    private

    def login_params
      params.permit(:username, :password)
    end
  end
end
