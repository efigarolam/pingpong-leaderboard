module ApplicationHelper
  def opponent_options
    users = User.where.not(email: current_user.email)
    users.map { |u| [u.email, u.id] }
  end
end
