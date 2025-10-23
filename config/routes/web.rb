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

    resources :los do
      post :duplicate, on: :member
      post 'uploader/image', to: 'uploader#image'

      resources :introductions do
        post :duplicate, on: :member
        post 'uploader/image', to: 'uploader#image'
      end

      resources :exercises do
        post :duplicate, on: :member
        post 'uploader/image', to: 'uploader#image'

        resources :solution_steps do
          post :duplicate, on: :member
          post 'uploader/image', to: 'uploader#image'

          resources :tips do
            post :duplicate, on: :member
          end
        end
      end
    end

      post 'uploader/image', to: 'uploader#image', as: :uploader_image
    end


  namespace :students do
    root to: 'home#dashboard'
  end
end
