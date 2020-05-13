module Api::V1
  class AccountsController < ApplicationController
    include Response
    include ExceptionHandler
    before_action :authorize_request, except: %i[create index]

    # GET /api/v1/accounts
    def index
      @accounts =
        if JsonWebToken.current_user(request)[:is_admin]
          logger.info "return all accounts"
          Account.all
        else
          logger.info "return an account"
          Account.find_by_user_id(JsonWebToken.current_user(request)[:user_id])
        end

      render json: @accounts, status: :ok
    end

    # GET /api/v1/accounts/{id}
    def show
      @account = Account.find(params[:id])
      if @account && JsonWebToken.current_user(request).is_admin
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
        header = request.headers["Authorization"]
        header = header.split(" ").last if header
        decoded = JsonWebToken.decode(header)

        logger.info "account is valid #{decoded}"
        
        if @account.status = 'confirmed' && @account.user_id.blank? 
          _user = 
            User.create(
              username: Crypt.decrypt(@account.email),
              password: ('0'..'z').to_a.shuffle.first(6).join,
              referral_code: ('0'..'z').to_a.shuffle.first(8).join,
              # indicated_referral_code: JsonWebToken.current_user(request).referral_code
            )
          @account.user_id = _user.id
        end

        render json: @account.id, status: :created
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
