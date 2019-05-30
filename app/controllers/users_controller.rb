# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.where.not(id: current_user.id).paginate(page: params[:page])
  end
end
