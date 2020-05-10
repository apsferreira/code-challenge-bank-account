module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_request, except: %i[create]

      # GET /users
      def index
          @users = if @current_user.is_admin
            User.all
          else
            User.find_by_indicated_referral_code(@current_user.referral_code)
          end

          if @users
            render json: @users, status: :ok
          else 
            render json: :no_content
          end
      end

      # GET /users/{id}
      def show
        render json: @user, status: :ok
      end

      # POST /users
      def create
        @user = User.new(user_params)

        user.is_admin = params[:is_admin] and current_user.is_admin?

        if @user.save
          render json: @user, status: :created
        else
          render json: { errors: @user.errors.full_messages },
                status: :unprocessable_entity
        end
      end

      # PUT /users/{id}
      def update
        unless @user.update(user_params)
          render json: { errors: @user.errors.full_messages },
                status: :unprocessable_entity
        end
      end

      # DELETE /users/{id}
      def destroy
        @user.destroy
      end

      private

      def find_user
        @user = User.find!(params[:id])
        rescue ActiveRecord::RecordNotFound
          render json: { errors: 'User not found' }, status: :not_found
      end

      def user_params
        params.permit(
          :username, :password, :password_confirmation, :referral_code, :is_admin
        )
      end
    end
  end
end
