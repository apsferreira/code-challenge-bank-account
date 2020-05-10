module Api
  module V1
    class AccountsController < ApplicationController
      before_action :authorize_request, except: %i[create, index]
      
      # GET /accounts
      def index
        @accounts = Account.all
        render json: @accounts, status: :ok
      end

      # GET /accounts/{id}
      def show
        render json: @account, status: :ok
      end

      # POST /accounts
      def create
        @account = Account.new(account_params)
        if @account.save
          render json: @account, status: :created
        else
          render json: { errors: @account.errors.full_messages },
                status: :unprocessable_entity
        end
      end

      # PUT /accounts/{id}
      def update
        unless @account.update(account_params)
          render json: { errors: @user.errors.full_messages },
                status: :unprocessable_entity
        end
      end

      # DELETE /accounts/{id}
      def destroy
        @account.destroy
      end

      private

      def account_params
        params.permit(
          :username, :email, :password, :password_confirmation
        )
      end
    end
  end
end
