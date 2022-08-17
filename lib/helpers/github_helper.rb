module GitHubHelper
  def users_get_request(uname)
    conn = Faraday.new(
      url: 'https://api.github.com',
      headers: { 'Content-Type' => 'application/json' }
    ) do |f|
      f.response :json
    end
    conn.get("users/#{uname}")
  end

  def save_user_repos(uname, user)
    conn = Faraday.new(
      url: 'https://api.github.com',
      headers: { 'Content-Type' => 'application/json' }
    ) do |f|
      f.response :json
    end
    @response_repos = conn.get("users/#{uname}/repos")
    @repos_names = []
    @response_repos.body.each do |repo|
      user.repositories.create({ 'title' => repo['name'] })
      @repos_names.append repo['name']
    end
  end
end
