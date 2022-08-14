Rails.application.routes.draw do
  root 'users#index'

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql'
  end

  resources :users do
    resources :repositories
  end

  post '/graphql', to: 'graphql#execute'
end
