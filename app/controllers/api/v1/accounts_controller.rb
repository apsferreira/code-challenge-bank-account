module Api::V1
  class AccountsController < ApplicationController
    include Response
    include ExceptionHandler
    before_action :authorize_request, except: %i[create, show]
    
    # GET /api/v1/accounts
    def index
      @accounts = 
        if @current_user.is_admin
          Account.all
        else
          Account.find(@current_user.id)
        end

      render json: @accounts, status: :ok
    end

    # GET /api/v1/accounts/{id}
    def show
      @account = Account.find(params[:id])
      if @account
        render json: @account, status: :ok
      else
        render json: @account, status: :not_found
      end
    end

    # POST /api/v1/accounts
    def create
      @account = Account.create(account_params)
      json_response(@account,:created)
    end

    # PUT /api/v1/accounts/{id}
    def update
      @account = Account.new(account_params)

      unless Account.create(@account)
        render json: { errors: @account.errors.full_messages },
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
        :name, :email, :cpf, :birth_date, :gender, :city, :state, :country
      )
    end
  end
end
