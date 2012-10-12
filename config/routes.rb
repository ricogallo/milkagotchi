Milkagotchi::Application.routes.draw do
  scope :api do
    resources :chicks
  end
  root to: "main#index"
  match "*all", to: "main#index"
end
