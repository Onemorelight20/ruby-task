require 'helpers/github_helper'

class UsersController < ApplicationController
  include GitHubHelper
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    uname = user_params[:username]
    @user = User.new(username: uname)

    @response = users_get_request(uname)
    if @response.status == 200

      if User.find_by_username(uname)
        render :new
      elsif @user.save
        save_user_repos(uname, @user)
        redirect_to root_path
      else
        render :new, status: :unprocessable_entity
      end
    else
      @error = 'User with such username does not exists'
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end


end
