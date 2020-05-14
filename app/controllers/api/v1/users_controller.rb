module Api::V1
  class UsersController < ApplicationController
    before_action :authorize_request

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
      begin
        @user =
          if JsonWebToken.current_user(request).is_admin
            User.find(params[:id])
          else
            User.find(JsonWebToken.current_user(request).id)
          end
      rescue ActiveRecord::RecordNotFound
        @user = nil
      end

      if @user
        render json: @user, status: :ok
      else
        render json: "Not Found", status: :not_found
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
        render json: {errors: @user.errors.full_messages},
               status: :unprocessable_entity
      end
    end

    # PUT /api/v1/users/{id}
    def update
      unless @user.update(user_params)
        render json: {errors: @user.errors.full_messages},
               status: :unprocessable_entity
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
