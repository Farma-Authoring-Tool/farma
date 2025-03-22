root to: 'home#index'
get '/test', to: 'home#test', as: 'test'

devise_for :users, controllers: { sessions: 'users/auth/sessions', registrations: 'users/auth/registrations' }
authenticate :user do
  get '/users', to: 'users/home#index'
end
