# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :username, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :repositories_count, Integer, null: true
    field :repositories, [Types::RepositoryType], null: true

    def repositories_count
      object.repositories.size
    end
  end
end
