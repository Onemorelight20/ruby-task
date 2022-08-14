module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :repositories,
          [Types::RepositoryType],
          null: false,
          description: "Return a list of repositories"

    def repositories
      Repository.all
    end
  end
end
