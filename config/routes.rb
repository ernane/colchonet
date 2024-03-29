Colchonet::Application.routes.draw do
  LOCALES = /en|pt\-BR/
  
  scope "(:locale)", :locale => LOCALES do
    resources :rooms do
      get 'page/:page', :action => :index, :on => :collection
      resources :reviews, :only => [:create, :update], :module => :rooms
    end
    resources :users
    
    resource :confirmation, :only => [:show]
    resource :user_sessions, :only => [:create, :new, :destroy]
  end
  
  match '/:locale' => 'home#index', :locale => LOCALES
  root :to => "home#index"
end
