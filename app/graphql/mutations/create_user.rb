require 'helpers/github_helper'

class Mutations::CreateUser < Mutations::BaseMutation
  include GitHubHelper

  argument :username, String, required: true

  field :user, Types::UserType, null: false
  field :errors, [String], null: false

  def resolve(username:)
    user = User.new(username: username)

    response = users_get_request(username)

    if User.find_by_username(username)
      { user: nil, errors: 'User is already saved'}
    elsif response.status == 200 and user.save
      save_user_repos(username, user)
      { user: user, errors: [] }
    else
      { user: nil, errors: user.errors.full_messages }
    end
  end
end
