root to: 'home#index'
get '/test', to: 'home#test', as: 'test'

devise_for :users, controllers: {
  sessions: 'users/auth/sessions',
  registrations: 'users/auth/registrations',
  passwords: 'users/auth/passwords'
}
authenticate :user do
  get '/users', to: 'users/home#index'
  get '/student',  to: 'student/home#index'
  get '/educator', to: 'educator/home#index'
end
