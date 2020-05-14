module RequestSpecHelper
  def json
    JSON.parse(response.body)
  end

  def authenticated_header
    token = JsonWebToken.encode(user_id: JsonWebToken.current_user.user_id, referral_code: JsonWebToken.current_user.referral_code, is_admin: JsonWebToken.current_user.is_admin)
    {'Authorization': "Bearer #{token}"}
  end
end
