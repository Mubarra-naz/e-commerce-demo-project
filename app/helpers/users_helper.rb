module UsersHelper
  def confirmation_status(user)
    return "Confirmed" if user.confirmed_at?

    "Unconfirmed"
  end
end
