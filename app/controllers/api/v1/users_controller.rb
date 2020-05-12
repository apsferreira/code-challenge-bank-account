module Api::V1
  class UsersController < ApplicationController
    before_action :authorize_request, except: %i[create]

    # GET /api/v1/users
    def index
      @users = if @current_user.is_admin
                User.all
              else
                User.find_by_indicated_referral_code(@current_user.referral_code)
              end

      if !@users.blank?
        render json: @users, status: :ok
      else
        render json: [], status: :ok
      end
    end

    # GET /api/v1/users/{id}
    def show
      begin
        @user =
          if current_user.is_admin
            User.find(params[:id])
          else
            User.find(current_user.id)
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
      params.permit(
        :username, :password, :password_confirmation, :referral_code, :is_admin
      )
    end
  end
end
