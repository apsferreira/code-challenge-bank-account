module RequestSpecHelper
  def json
    JSON.parse(response.body)
  end

  def authenticated_header(user)
    token = JsonWebToken.encode(user_id: "9edf0c82-938c-11ea-bb37-0242ac130002", referral_code: @user.referral_code, is_admin: @user.is_admin)
    {'Authorization': "Bearer #{token}"}
  end
end
