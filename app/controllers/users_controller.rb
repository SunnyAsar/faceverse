# frozen_string_literal: true

class UsersController < ApplicationController

  before_action :find_user, only: [ :show, :update, :edit]

  def index
    @users = User.where.not(id: current_user.id).paginate(page: params[:page])
  end


  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(update_params)
    if @user
      flash[:success] = "profile Updated!"
      redirect_to @user
    else
      render 'edit'
    end
  end



  private

  def update_params
    params.require(:user).permit(:first_name, :last_name, :age,:country, profile_attributes: [:id, :age,:country, :user, :profile_picture])
  end

  def find_user
    @user = User.find(params[:id])
  end

end
