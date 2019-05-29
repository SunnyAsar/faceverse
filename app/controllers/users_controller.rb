class UsersController < ApplicationController
  def index
    @users = User.all.reject{ |user| user == current_user }
  end

end
