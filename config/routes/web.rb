root to: 'home#index'

devise_for :users, controllers: {
  sessions: 'users/auth/sessions',
  registrations: 'users/auth/registrations',
  passwords: 'users/auth/passwords'
}

authenticate :user do
  get '/profile/choose', to: 'users/profile#choose', as: :users_choose_profile

  namespace :educators do
    root to: 'home#dashboard'
  end

  namespace :students do
    root to: 'home#dashboard'
  end
end
