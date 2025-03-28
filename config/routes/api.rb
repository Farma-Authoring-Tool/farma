devise_scope :user do
  post '/api/signup', to: 'api/users/registrations#create', defaults: { format: 'json' }, as: :api_user_registration

  post '/api/login', to: 'api/users/sessions#create', defaults: { format: 'json' }, as: :api_user_session
  delete '/api/logout', to: 'api/users/sessions#destroy', defaults: { format: 'json' }, as: :api_destroy_user_session
end

authenticate :user do
  namespace :api do
    namespace :professors do
      resources :los do
        post 'duplicate', on: :member
        post 'sort_pages', on: :member

        resources :introductions do
          post 'duplicate', on: :member
        end

        resources :exercises do
          post 'duplicate', on: :member
          resources :solution_steps do
            post 'reorder', on: :collection
            post 'duplicate', on: :member

            resources :tips do
              post 'reorder', on: :collection
              post 'duplicate', on: :member
            end
          end
        end
      end
    end

    # Routes to visualizations lo ids
    namespace :view do
      get 'teams/:team_id/los/:id', to: 'teams/los#show', as: :team_lo
      get 'teams/:team_id/los/:id/page/:page', to: 'teams/page#show', as: :team_lo_page
      post 'teams/:team_id/los/:lo_id/exercises/:exercise_id/solution_steps/:solution_step_id/view',
           to: 'teams/solution_step#view', as: :team_solution_step_view
      post 'teams/:team_id/los/:lo_id/exercises/:exercise_id/solution_steps/:solution_step_id/answer',
           to: 'teams/solution_step#respond', as: :team_solution_step_respond
      get 'teams/:team_id/los/:lo_id/exercises/:exercise_id/solution_steps/:solution_step_id/tips/request',
          to: 'teams/tip#available_tip', as: :team_tips_request
      get 'professors/los/:id', to: 'professors/lo#show', as: :professor_lo
      get 'professors/los/:id/page/:page', to: 'professors/page#show', as: :professor_lo_page
      post 'professors/los/:id/exercises/:exercise_id/solution_steps/:solution_step_id/answer',
           to: 'professors/solution_step#respond', as: :professor_solution_step_respond
      get 'professors/los/:id/exercises/:exercise_id/solution_steps/:solution_step_id/tips/request',
          to: 'professors/tip#available_tip', as: :professor_tips_request
      post 'professors/los/:id/exercises/:exercise_id/solution_steps/:solution_step_id/view',
           to: 'professors/solution_step#view', as: :professor_solution_step_view

      get 'guests/los/:id/exercises/:exercise_id/solution_steps/:solution_step_id/tips/request',
          to: 'guests/tip#available_tip', as: :guest_tips_request
      get 'guests/los/:id/page/:page', to: 'guests/page#show', as: :guest_lo_page
      post 'guests/los/:id/exercises/:exercise_id/solution_steps/:solution_step_id/view',
           to: 'guests/solution_step#view', as: :guest_solution_step_view
      post 'guests/los/:id/exercises/:exercise_id/solution_steps/:solution_step_id/answer',
           to: 'guests/solution_step#respond', as: :guest_solution_step_respond
    end
  end
end

namespace :api do
  namespace :view do
    get 'guests/los/:id', to: 'guests/lo#show', as: :guest_lo
  end
end
