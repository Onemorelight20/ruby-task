Rails.application.routes.draw do
  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"

  root 'users#index'

  resources :users do
    resources :repositories
  end

  post '/graphql', to: 'graphql#execute'
end
