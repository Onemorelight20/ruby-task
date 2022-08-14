class UsersController < ApplicationController
  @@conn = Faraday.new(
    url: 'https://api.github.com',
    params: { param: '1' },
    headers: { 'Content-Type' => 'application/json' }
  ) do |f|
    f.response :json
  end

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

    @response = @@conn.get("users/#{uname}")
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
      @error = "User with such username does not exists"
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

  def save_user_repos(uname, user)
    @response_repos = @@conn.get("users/#{uname}/repos")
    @repos_names = []
    (@response_repos.body).each do |repo|
      user.repositories.create({ "title" => repo["name"] })
      @repos_names.append repo["name"]
    end

  end
end
