module UsersHelper
  def user_is_premium?
    if user_signed_in?
      current_user.premium?
    else
      false
    end
  end
end
