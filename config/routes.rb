Rails.application.routes.draw do
  devise_for :users,
              path: '',
                  path_names: {
                  sign_in: 'login',
                  sign_out: 'logout',
                  registration: 'signup'
              },
                  controllers: {
                  sessions: 'sessions',
                  registrations: 'registrations'
              }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      concern :commentable do
        resources :comments, except: :show
      end
      resources :movies, concerns: :commentable
      resources :posts do
        concerns :commentable
        collection do
          get 'search'
          get 'popular'
          get 'hot'
        end
      end
      resources :actors
      resources :director
      resources :genres
      resources :comments, only: [:index, :show] do
        resources :likes, only: [:index, :create]
      end
    end
  end
end
