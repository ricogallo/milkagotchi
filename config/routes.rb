Milkagotchi::Application.routes.draw do
  scope 'api' do
    resources :chicks do
      member do
        post 'feed'
        post 'clean'
        post 'play'
        post 'deliver_milk'
      end
    end
  end
  
  root to: "main#index"
  match '*path', to: "main#index"
end
