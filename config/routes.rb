Rails.application.routes.draw do

  root 'welcome#index'

  get 'home' => 'welcome#index'

  devise_for :users, path: "auth"

  scope module: 'granted' do
    resources :contacts

    post 'pusher/auth'

    resources :groups do
      resources :contacts
    end

  end


end
