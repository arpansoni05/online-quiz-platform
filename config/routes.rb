Rails.application.routes.draw do
  devise_for :users , controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :admins

  namespace :api do
    namespace :v1 do
        resources :assessments do
          resources :questions do
            resources :answers
          end
          resources :coding_questions
        end
      resources :users
      resources :allocations

      post '/assessments/:assessment_id/assign_assessments', to: "assessments#assign_assessments"
      get 'show_assign_assessments', to: "assessments#show_assign_assessments"
      get '/assessments/:assessment_id/take', to: "allocations#take"
      post '/assessments/:assessment_id/submit', to: "allocations#submit"
      # post '/assessments/:assessment_id/take_coding_assessment', to: "allocations#take_coding_assessment"
      # post '/compile_code', to: 'compiler#compile_code'
    end
  end
end
