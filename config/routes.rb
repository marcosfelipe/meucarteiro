Rails.application.routes.draw do


  devise_for :users, path: "auth"


  root 'welcome#index'


  get 'home' => 'welcome#index'


end
