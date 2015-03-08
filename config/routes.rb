Rails.application.routes.draw do

  root 'welcome#index'

  get 'home' => 'welcome#index'

  devise_for :users, path: "auth"

  #escopo para pasta de usuário autenticado
  scope module: 'granted' do
    resources :contacts

    post 'pusher/auth'

    resources :groups do
      resources :contacts
    end

    #duplicar grupo
    post 'group/duplicate', controller: :groups, action: :duplicate

  end


end
