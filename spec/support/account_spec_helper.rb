module RequestSpecHelper  
  def json
    JSON.parse(response.body)
  end

  def authenticated_header(request, user)
    token = JsonWebToken.encode(user_id: @user.id, referral_code: @user.referral_code, is_admin: @user.is_admin)
    { 'Authorization': "Bearer #{token}" }
  end
end