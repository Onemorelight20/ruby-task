Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  root 'users#index'

  resources :users do
    resources :repositories
  end

  post '/graphql', to: 'graphql#execute'
end
