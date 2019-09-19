module ApplicationHelper
  def owner?(user)
    current_user == user
  end
end
