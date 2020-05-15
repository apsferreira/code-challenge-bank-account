require 'bcrypt'

module Api::V1
  class AccountsController < ApplicationController
    include ExceptionHandler
    before_action :authorize_request, except: [:create]

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
        raise ExceptionHandler::AccessDenied, "Access denied"
      end
    end

    # POST /api/v1/accounts
    def create
      account = Account.new(account_params)
      if account.valid?
        account.validation_status

        @password = SecureRandom.alphanumeric(6)

        if account.status == 'completed' && account.user_id.blank? 
          account.indicated_referral_code = 
            if account.indicated_referral_code.blank? && !JsonWebToken.current_user(request).blank? 
              JsonWebToken.current_user(request).referral_code
            end
            
          @user = 
            User.new(
              username: account.email,
              password: @password,
              referral_code: SecureRandom.alphanumeric(8)
            )
          
            if @user.valid? && @user.save
              account.user_id = @user.id  
              @referral_code = @user.referral_code
              account.process
            else
              @user = User.find_by_username(account.email)
              @user.password_digest = BCrypt::Password.create(@password) if @user
              @referral_code = @user.referral_code
              account.user_id = @user.id
              account.process
            end 
        else
          account.process
        end

        render json: { account: account, referral_code: @referral_code,  access: { username: Crypt.decrypt(account.email), password: @password }}, status: :created
      else
        logger.info "account is invalid"
        raise ExceptionHandler::RecordInvalid, account.errors.full_messages
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
