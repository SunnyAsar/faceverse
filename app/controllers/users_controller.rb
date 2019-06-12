# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all_without(current_user).paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
  end
end
