module Api::V1
  class UsersController < ApplicationController
    include ExceptionHandler
    before_action :authorize_request, except: [:create]

    # GET /api/v1/users
    def index
      users = 
        if JsonWebToken.current_user(request).is_admin
          User.all
        else
          User.find(JsonWebToken.current_user(request).id)
        end

      render json: users, adapter: :json
    end

    # GET /api/v1/users/{id}
    def show
      @user =
        if JsonWebToken.current_user(request).is_admin
          User.find(params[:id])
        else
          raise ExceptionHandler::AccessDenied, 'Access Denied'
        end

      if @user
        render json: @user, status: :ok
      else
        raise ExceptionHandler::RecordNotFound, 'User not found'
      end
    end

    # POST /api/v1/users
    def create
      @user = User.new(user_params)
      
      logger.info "user sochin #{@user.referral_code} #{@user.password}"
      @user.password = params[:password]

      if @user.save
        render json: @user, status: :created
      else
        raise ExceptionHandler::RecordInvalid, @user.errors.full_messages
      end
    end

    # PUT /api/v1/users/{id}
    def update
      unless @user.update(user_params)
        raise ExceptionHandler::RecordInvalid, @user.errors.full_messages
      end
    end

    # DELETE /api/v1/users/{id}
    def destroy
      User.find(params[:id]).destroy
    end

    private

    def user_params
      params.require(:user).permit(
        :username, :password, :referral_code, :is_admin
      )
    end
  end
end
