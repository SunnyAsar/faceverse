class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def require_permission(owner)
    return if owner == current_user
    
    flash[:alert] = 'You have no permission'
    redirect_back fallback_location: root_path
  end

end
