Milkagotchi::Application.routes.draw do
  scope "api" do
    resources :chicks
  end
  
  root to: "main#index"
  match '*path', to: "main#index"
end
