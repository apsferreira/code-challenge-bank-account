class JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  end

  def self.current_user(request)
    header = request.headers["Authorization"]
    header = header.split(" ").last if header
    
    if !header.blank?
      User.find(JsonWebToken.decode(header)[:user_id])
    end
  end
end
