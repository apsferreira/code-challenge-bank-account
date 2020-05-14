module Api::V1
  class AccountsController < ApplicationController
    before_action :authorize_request

    # GET /api/v1/accounts
    def index
      if JsonWebToken.current_user(request).is_admin
        logger.info "return all accounts"
        @accounts = 
          Account.all.each do |account| 
            account.name = Crypt.decrypt(account.name) 
          end
      else 
        logger.info "return associated accounts"
        @accounts = Account.find_by_indicated_referral_code(JsonWebToken.current_user(request).referral_code)
        @accounts.name = Crypt.decrypt(@accounts.name) if !@accounts.blank?
      end
      
      if !@accounts.blank?
        render json: @accounts, status: :ok
      else
        render json: [], status: :ok
      end
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
      account = Account.new(account_params)
      if account.valid?
        if account.status == 'completed' && account.user_id.blank? 
          byebug
          indicated_referral_code =  
            if JsonWebToken.current_user(request).blank? 
              JsonWebToken.current_user(request).referral_code
            else
              account.indicated_referral_code
            end
          
          @password = ('0'..'z').to_a.shuffle.first(6).join

          @user = 
            User.create(
              username: Crypt.decrypt(account.email),
              password: @password,
              referral_code: ('0'..'z').to_a.shuffle.first(8).join,
              indicated_referral_code: indicated_referral_code
            )

            logger.debug "user #{@user.valid?}"
          
          account.user_id = @user.id  
        end
        
        account.process

        render json: { account: account, password: @password }, status: :created
      else
        logger.info "account is invalid"
        render json: {errors: account.errors.full_messages},
               status: :unprocessable_entity
      end
    end

    # DELETE /api/v1/accounts/{id}
    def destroy
      @account.destroy
    end

    private

    def account_params
      params.require(:account).permit(
        :name, :email, :cpf, :birth_date, :gender, :city, :state, :country, :indicated_referral_code
      )
    end
  end
end
