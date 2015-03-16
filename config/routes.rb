Rails.application.routes.draw do

  root 'welcome#index'

  get 'home' => 'welcome#index'

  devise_for :users, path: "auth"

  #escopo para pasta de usuário autenticado
  scope module: 'granted' do

    resources :contacts, except: [:show]

    post 'pusher/auth'

    resources :groups do
      resources :contacts, only:[:create, :index, :new]
    end

    #duplicar grupo
    post 'group/duplicate', controller: :groups, action: :duplicate

    get 'dashboard', controller: :dashboard, action: :index

  end


end
