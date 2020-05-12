module Api::V1
  class AccountsController < ApplicationController
    include Response
    include ExceptionHandler
    before_action :authorize_request, except: %i[create show]

    # GET /api/v1/accounts
    def index
      @accounts =
        if @current_user.is_admin
          logger.info "return all accounts"
          Account.all
        else
          logger.info "return an account"
          Account.find_by_user_id(@current_user.id)
        end

      render json: @accounts, status: :ok
    end

    # GET /api/v1/accounts/{id}
    def show
      @account = Account.find(params[:id])
      if @account && current_user.is_admin
        logger.info "show an account"
        render json: @account, status: :ok
      else
        logger.info "not authorize"
        render json: @account, status: :unauthorized
      end
    end

    # POST /api/v1/accounts
    def create
      logger.info "create or update an account"
      @account = Account.new(account_params)
      
      if @account.valid?
        logger.info "account is valid"
        render json: Account.upsert(account_params, unique_by: :cpf), status: :created
      else
        logger.info "account is invalid"
        render json: {errors: @account.errors.full_messages},
               status: :unprocessable_entity
      end
    end

    # DELETE /api/v1/accounts/{id}
    def destroy
      @account.destroy
    end

    private

    def set_account
      @set_account = Account.find(params[:id])
    end

    def account_params
      params.require(:account).permit(
        :name, :email, :cpf, :birth_date, :gender, :city, :state, :country, :status
      )
    end
  end
end
