class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end
end
