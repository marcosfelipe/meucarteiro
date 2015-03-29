Rails.application.routes.draw do


  localized do

    root 'welcome#beta'

    get 'beta' => 'welcome#beta'

    get 'home' => 'welcome#index'

    devise_for :users, path: "auth"

    #escopo para pasta de usuário autenticado
    scope module: 'granted' do

      #contatos
      resources :contacts, except: [:show]

      #importação
      get 'import/contacts' => 'imports#new', path_for_action: 'import_contacts'
      post 'import/contacts' => 'imports#create', path_for_action: 'import_contacts'

      #para autenticação do push
      post 'pusher/auth'

      #grupos com contatos
      resources :groups do
        resources :contacts, only: [:create, :index, :new]
      end

      #duplicar grupo
      post 'group/duplicate', controller: :groups, action: :duplicate

      #dash
      get 'dashboard' => "dashboard#index"

      #envios
      get 'shipments/new' => "shipments#new", path_for_action: 'new_shipment'
      post 'shipments' => "shipments#create", path_for_action: 'shipments'
      get 'shipments' => "shipments#index"


    end

  end


end
